# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # List permissions
    #
    # @see https://developers.files.com/#list-permissions List permissions
    #
    class ListPermissions
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE   | DESCRIPTION
      # --------- | ------ | -----------
      # path      | string | Permission path.
      Params = Struct.new(
        'ListPermissionsParams',
        :path,
        keyword_init: true
      )

      # List permissions
      #
      # @param [BrickFTP::RESTfulAPI::ListPermissions::Params] params parameters
      # @return [Array<BrickFTP::Types::Permission>]
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact

        endpoint = '/api/rest/v1/permissions.json'
        query = params.sort.map { |k, v| "#{k}=#{ERB::Util.url_encode(v.to_s)}" }.join('&')
        endpoint += "?#{query}" unless query.empty?
        res = client.get(endpoint)

        res.map { |i| BrickFTP::Types::Permission.new(i.symbolize_keys) }
      end
    end
  end
end
