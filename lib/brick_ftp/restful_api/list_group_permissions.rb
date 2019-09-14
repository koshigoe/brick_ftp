# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # List group's permissions
    #
    # @see https://developers.files.com/#list-group-39-s-permissions List group's permissions
    #
    # ### Params
    #
    # PARAMETER      | TYPE    | DESCRIPTION
    # -------------- | ------- | -----------
    # id             | integer | Required: Group ID.
    #
    class ListGroupPermissions
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'ListGroupPermissionsParams',
        :id,
        keyword_init: true
      )

      # List group's permissions
      #
      # @param [BrickFTP::RESTfulAPI::ListGroupPermissions::Params] params parameters
      # @return [Array<BrickFTP::Types::Permission>]
      #
      def call(params)
        res = client.get("/api/rest/v1/groups/#{params[:id]}/permissions.json")

        res.map { |i| BrickFTP::Types::Permission.new(i.symbolize_keys) }
      end
    end
  end
end
