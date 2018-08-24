# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Remove a member
    #
    # @see https://developers.brickftp.com/#remove-a-member Remove a member
    #
    class RemoveGroupMember
      include Command

      # Removes a user from a group. No action will be taken if the user is not already in the group.
      #
      # @param [Integer] group_id ID of the group the membership is associated with.
      # @param [Integer] user_id ID of the user the membership is associated with.
      #
      def call(group_id, user_id)
        client.delete("/api/rest/v1/groups/#{group_id}/memberships/#{user_id}.json")
        true
      end
    end
  end
end
