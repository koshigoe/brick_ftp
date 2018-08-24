# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Add a member
    #
    # @see https://developers.brickftp.com/#add-a-member Add a member
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # admin     | boolean | Indicates whether the user is an administrator of the group.
    #
    class AddGroupMember
      include Command

      Params = Struct.new(
        'AddGroupMemberParams',
        :admin,
        keyword_init: true
      )

      # Adds a user to a group.
      #
      # - By default, the member will not be an admin.
      # - If the user is already a member of the group, their attributes will be updated to match the request.
      #
      # @param [Integer] group_id ID of the group the membership is associated with.
      # @param [Integer] user_id ID of the user the membership is associated with.
      # @param [BrickFTP::RESTfulAPI::AddGroupMember::Params] params parameters
      # @return [BrickFTP::Types::GroupMembership] group membership
      # @raise [BrickFTP::RESTfulAPI::Error] exception
      #
      def call(group_id, user_id, params)
        res = client.put("/api/rest/v1/groups/#{group_id}/memberships/#{user_id}.json", membership: params.to_h.compact)

        BrickFTP::Types::GroupMembership.new(res.symbolize_keys)
      end
    end
  end
end
