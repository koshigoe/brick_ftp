# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # The Permission object
    #
    # @see https://developers.files.com/#the-permission-object The Permission object
    #
    # ATTRIBUTE  | TYPE    | DESCRIPTION
    # ---------- | ------- | -----------
    # id         | integer | Permission ID
    # user_id    | integer | User ID
    # username   | string  | User's username
    # group_id   | integer | Group ID
    # group_name | string  | Group name if applicable
    # path       | string  | Folder path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # permission | string  | Permission type. Can be full, readonly, writeonly, previewonly, or history
    # recursive  | boolean | Does this permission apply to subfolders?
    #
    Permission = Struct.new(
      'Permission',
      :id,
      :user_id,
      :username,
      :group_id,
      :group_name,
      :path,
      :permission,
      :recursive,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
