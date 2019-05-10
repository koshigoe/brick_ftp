# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # The group object
    #
    # @see https://developers.files.com/#the-group-object The group object
    #
    # ATTRIBUTE | TYPE                     | DESCRIPTION
    # --------- | ------------------------ | -----------
    # id        | integer                  | Globally unique identifier of each group. Each group is given an ID automatically upon creation.
    # name      | string                   | Name of the group. This is how the group will be displayed on the site. Maximum of 50 characters.
    # notes     | text                     | You may use this property to store any additional information you require. There are no restrictions on its formatting.
    # user_ids  | comma-separated integers | IDs of the users that are in this group.
    # usernames | string                   | Usernames of the users that are in this group.
    # admin_ids | comma-separated integers | IDs of the users that are in this group and are administrators of this group.
    #
    Group = Struct.new(
      'Group',
      :id,
      :name,
      :notes,
      :user_ids,
      :usernames,
      :admin_ids,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
