# frozen_string_literal: true

module BrickFTP
  module Types
    GroupMembership = Struct.new(
      'GroupMembership',
      :id,       # integer | Globally unique identifier for the membership.
      :group_id, # integer | ID of the group the membership is associated with.
      :user_id,  # integer | ID of the user the membership is associated with.
      :admin,    # boolean | Indicates whether the user is an administrator of the group.
      keyword_init: true
    )
  end
end
