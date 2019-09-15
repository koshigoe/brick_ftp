# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # List current user's group memberships
    #
    # @see https://developers.files.com/#list-current-user-39-s-group-memberships List current user's group memberships
    #
    class ListCurrentUserGroupMemberships
      include Command
      using BrickFTP::CoreExt::Hash

      # List current user's group memberships
      #
      # @return [Array<BrickFTP::Types::Group>]
      #
      def call
        res = client.get('/api/rest/v1/user/groups.json')

        res.map { |i| BrickFTP::Types::Group.new(i.symbolize_keys) }
      end
    end
  end
end
