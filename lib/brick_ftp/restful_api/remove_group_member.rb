# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete group membership
    #
    # @see https://developers.files.com/#delete-group-membership Delete group membership
    #
    class RemoveGroupMember
      include Command

      # Delete group membership
      #
      # @param [Integer] id Group ID.
      # @param [Integer] user_id User ID.
      #
      def call(id, user_id)
        client.delete("/api/rest/v1/groups/#{id}/memberships/#{user_id}.json")
        true
      end
    end
  end
end
