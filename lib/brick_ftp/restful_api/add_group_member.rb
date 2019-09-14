# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Add a User to a Group
    #
    # @see https://developers.files.com/#add-a-user-to-a-group Add a User to a Group
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
        :id,
        :user_id,
        :admin,
        keyword_init: true
      )

      # Add a User to a Group
      #
      # @param [BrickFTP::RESTfulAPI::AddGroupMember::Params] params parameters
      # @return [BrickFTP::Types::GroupMembership]
      # @raise [BrickFTP::RESTfulAPI::Error] exception
      #
      def call(params)
        params = params.to_h.compact
        id = params.delete(:id)
        user_id = params.delete(:user_id)
        res = client.put("/api/rest/v1/groups/#{id}/memberships/#{user_id}.json", params)

        BrickFTP::Types::GroupMembership.new(res.symbolize_keys)
      end
    end
  end
end
