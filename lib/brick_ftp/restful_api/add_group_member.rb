# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Add a User to a Group
    #
    # @see Add a User to a Group
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Required: Group ID.
    # user_id   | integer | Required: User ID to add to group.
    # admin     | boolean | Is the user a group administrator?
    #
    class AddGroupMember
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'AddGroupMemberParams',
        :admin,
        keyword_init: true
      )

      # Add a User to a Group
      #
      # @param [Integer] id Group ID
      # @param [Integer] user_id User ID to add to Group.
      # @param [BrickFTP::RESTfulAPI::AddGroupMember::Params] params parameters
      # @return [BrickFTP::Types::GroupMembership]
      # @raise [BrickFTP::RESTfulAPI::Error] exception
      #
      def call(id, user_id, params)
        res = client.put("/api/rest/v1/groups/#{id}/memberships/#{user_id}.json", params.to_h.compact)

        BrickFTP::Types::GroupMembership.new(res.symbolize_keys)
      end
    end
  end
end
