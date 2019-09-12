# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # The Group object
    #
    # @see https://developers.files.com/#the-group-object The Group object
    #
    # ATTRIBUTE | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Group ID
    # admin_ids | array   | List of user IDs who are group administrators
    # name      | string  | Group name
    # notes     | string  | Notes about this group
    # user_ids  | array   | List of user IDs who belong to this group
    # usernames | array   | List of usernames who belong to this group
    #
    Group = Struct.new(
      'Group',
      :id,
      :admin_ids,
      :name,
      :notes,
      :user_ids,
      :usernames,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
