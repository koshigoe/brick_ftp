# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # membership object
    #
    # @see https://developers.files.com/#add-a-member membership object
    #
    # ATTRIBUTE | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Globally unique identifier for the membership.
    # group_id  | integer | ID of the group the membership is associated with.
    # user_id   | integer | ID of the user the membership is associated with.
    # admin     | boolean | Indicates whether the user is an administrator of the group.
    #
    GroupMembership = Struct.new(
      'GroupMembership',
      :id,
      :group_id,
      :user_id,
      :admin,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
