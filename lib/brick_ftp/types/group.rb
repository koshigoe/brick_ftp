# frozen_string_literal: true

module BrickFTP
  module Types
    # rubocop:disable Metrics/LineLength
    Group = Struct.new(
      'Group',
      :id,        # integer                  | Globally unique identifier of each group. Each group is given an ID automatically upon creation.
      :name,      # string                   | Name of the group. This is how the group will be displayed on the site. Maximum of 50 characters.
      :notes,     # text                     | You may use this property to store any additional information you require. There are no restrictions on its formatting.
      :user_ids,  # comma-separated integers | IDs of the users that are in this group.
      :usernames, # string                   | Usernames of the users that are in this group.
      :admin_ids, # array<integer>           | IDs of the users that are in this group and are administrators of this group.
      keyword_init: true
    )
    # rubocop:enable Metrics/LineLength
  end
end
