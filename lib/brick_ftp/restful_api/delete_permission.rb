# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete permission
    #
    # @see https://developers.files.com/#delete-permission Delete permission
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Required: Permission ID.
    #
    class DeletePermission
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'DeletePermissionParams',
        :id,
        keyword_init: true
      )

      # Delete permission
      #
      # @param [BrickFTP::RESTfulAPI::DeletePermission::Params] params parameters
      #
      def call(params)
        params = Params.new(params.to_h).to_h.compact
        client.delete("/api/rest/v1/permissions/#{params.delete(:id)}.json")
        true
      end
    end
  end
end
