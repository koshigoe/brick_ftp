# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete group membership
    #
    # @see https://developers.files.com/#delete-group-membership Delete group membership
    #
    class RemoveGroupMember
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE    | DESCRIPTION
      # --------- | ------- | -----------
      # id        | integer | Required: Group ID.
      # user_id   | integer | Required: User ID to add to group.
      Params = Struct.new(
        'RemoveGroupMemberParams',
        :id,
        :user_id,
        keyword_init: true
      )

      # Delete group membership
      #
      # @param [BrickFTP::RESTfulAPI::RemoveGroupMember::Params] params parameters
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        id = params.delete(:id)
        user_id = params.delete(:user_id)
        client.delete("/api/rest/v1/groups/#{id}/memberships/#{user_id}.json")
        true
      end
    end
  end
end
