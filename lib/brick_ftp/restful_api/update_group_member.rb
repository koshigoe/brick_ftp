# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Update group membership
    #
    # @see https://developers.files.com/#update-group-membership Update group membership
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Required: Group ID.
    # user_id   | integer | Required: User ID to add to group.
    # admin     | boolean | Is the user a group administrator?
    #
    class UpdateGroupMember
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'UpdateGroupMemberParams',
        :id,
        :user_id,
        :admin,
        keyword_init: true
      )

      # Update group membership
      #
      # @param [BrickFTP::RESTfulAPI::UpdateGroupMember::Params] params parameters
      # @return [BrickFTP::Types::GroupMembership]
      #
      def call(params)
        params = params.to_h.compact
        id = params.delete(:id)
        user_id = params.delete(:user_id)
        res = client.patch("/api/rest/v1/groups/#{id}/memberships/#{user_id}.json", params)

        BrickFTP::Types::GroupMembership.new(res.symbolize_keys)
      end
    end
  end
end
