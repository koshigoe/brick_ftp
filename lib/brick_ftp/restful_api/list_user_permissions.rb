# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # List user's permissions
    #
    # @see https://developers.files.com/#list-user-39-s-permissions List user's permissions
    #
    class ListUserPermissions
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER      | TYPE    | DESCRIPTION
      # -------------- | ------- | -----------
      # id             | integer | Required: User ID.
      # include_groups | boolean | Include group permissions?
      Params = Struct.new(
        'ListUserPermissionsParams',
        :id,
        :include_groups,
        keyword_init: true
      )

      # List user's permissions
      #
      # @param [BrickFTP::RESTfulAPI::ListUserPermissions::Params] params parameters
      # @return [Array<BrickFTP::Types::Permission>]
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact

        endpoint = "/api/rest/v1/users/#{params.delete(:id)}/permissions.json"
        query = params.sort.map { |k, v| "#{k}=#{ERB::Util.url_encode(v.to_s)}" }.join('&')
        endpoint += "?#{query}" unless query.empty?
        res = client.get(endpoint)

        res.map { |i| BrickFTP::Types::Permission.new(i.symbolize_keys) }
      end
    end
  end
end
