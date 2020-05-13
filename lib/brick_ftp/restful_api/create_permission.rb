# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create a permission
    #
    # @see https://developers.files.com/#create-a-permission Create a permission
    #
    # ### Params
    #
    # PARAMETER  | TYPE    | DESCRIPTION
    # ---------- | ------- | -----------
    # user_id    | integer | Unique identifier for the user being granted a permission. Each user is given an ID automatically upon creation. The user_id and group_id fields cannot both be set.
    # username   | string  | Username for the user, if user_id is set. If this value is set during creation and user_id is not set, the user_id is looked up from the username and set. Maximum of 50 characters.
    # group_id   | integer | Unique identifier for the group being granted a permission. Each group is given an ID automatically upon creation. The user_id and group_id fields cannot both be set.
    # path       | string  | Folder path for the permission to apply to. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # permission | enum    | Value must be set to full, readonly, writeonly, previewonly, or history, depending on the type of access to be granted by the Permission.
    # recursive  | boolean | If set to false, the permission will be non-recursive, and will not apply to subfolders of the folder specified by the path property. Default is true.
    #
    class CreatePermission
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'CreatePermissionParams',
        :user_id,
        :username,
        :group_id,
        :path,
        :permission,
        :recursive,
        keyword_init: true
      )

      # Creates a new permission record.
      #
      # @param [BrickFTP::RESTfulAPI::CreatePermission::Params] params parameters
      # @return [BrickFTP::Types::Permission] Permissions
      #
      def call(params)
        res = client.post('/api/rest/v1/permissions.json', params.to_h.compact)

        BrickFTP::Types::Permission.new(**res.symbolize_keys)
      end
    end
  end
end
