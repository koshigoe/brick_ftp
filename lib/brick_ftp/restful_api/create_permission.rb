# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create permission
    #
    # @see https://developers.files.com/#create-permission Create permission
    #
    # ### Params
    #
    # PARAMETER  | TYPE    | DESCRIPTION
    # ---------- | ------- | -----------
    # group_id   | integer | Group ID
    # path       | string  | Folder path
    # permission | object  | Permission type. Can be full, readonly, writeonly, previewonly, or history
    # recursive  | boolean | Apply to subfolders recursively?
    # user_id    | integer | User ID. Provide username or user_id
    # username   | string  | User username. Provide username or user_id
    #
    class CreatePermission
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'CreatePermissionParams',
        :group_id,
        :path,
        :permission,
        :recursive,
        :user_id,
        :username,
        keyword_init: true
      )

      # Create permission
      #
      # @param [BrickFTP::RESTfulAPI::CreatePermission::Params] params parameters
      # @return [BrickFTP::Types::Permission]
      #
      def call(params = {})
        res = client.post('/api/rest/v1/permissions.json', Params.new(params.to_h).to_h.compact)

        BrickFTP::Types::Permission.new(res.symbolize_keys)
      end
    end
  end
end
