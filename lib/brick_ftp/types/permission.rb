# frozen_string_literal: true

module BrickFTP
  module Types
    # rubocop:disable Metrics/LineLength
    Permission = Struct.new(
      'Permission',
      :id,         # integer | Globally unique identifier of each permission. Each permission is given an ID automatically upon creation.
      :user_id,    # integer | Unique identifier for the user being granted a permission. Each user is given an ID automatically upon creation. The user_id and group_id fields cannot both be set.
      :username,   # string  | Username for the user, if user_id is set. If this value is set during creation and user_id is not set, the user_id is looked up from the username and set. Maximum of 50 characters.
      :group_id,   # integer | Unique identifier for the group being granted a permission. Each group is given an ID automatically upon creation. The user_id and group_id fields cannot both be set.
      :group_name, # string  | Name of the group, if group_id is set. This property is read-only.
      :path,       # string  | Folder path for the permission to apply to. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
      :permission, # enum    | Value must be set to full, readonly, writeonly, previewonly, or history, depending on the type of access to be granted by the Permission.
      :recursive,  # boolean | If set to false, the permission will be non-recursive, and will not apply to subfolders of the folder specified by the path property. Default is true.
      keyword_init: true
    )
    # rubocop:enable Metrics/LineLength
  end
end
