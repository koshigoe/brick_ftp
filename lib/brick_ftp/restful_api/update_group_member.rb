# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    class UpdateGroupMember
      include Command

      Params = Struct.new(
        'AddGroupMemberParams',
        :admin, # boolean | Indicates whether the user is an administrator of the group.
        keyword_init: true
      )

      # Updates a user's group membership. No action will be taken if the user is not already in the group.
      #
      # @param [Integer] group_id ID of the group the membership is associated with.
      # @param [Integer] user_id ID of the user the membership is associated with.
      # @param [BrickFTP::RESTfulAPI::UpdateGroupMember::Params] params parameters
      # @return [BrickFTP::Types::GroupMembership] group membership
      #
      def call(group_id, user_id, params)
        res = client.patch("/api/rest/v1/groups/#{group_id}/memberships/#{user_id}.json", membership: params.to_h.compact)

        BrickFTP::Types::GroupMembership.new(res.symbolize_keys)
      end
    end
  end
end
