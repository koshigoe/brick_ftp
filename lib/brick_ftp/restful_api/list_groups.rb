# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # List all groups
    #
    # @see https://developers.brickftp.com/#list-all-groups List all groups
    #
    class ListGroups
      include Command

      # Returns a list of all groups on the current site.
      #
      # @return [Array<BrickFTP::Types::Group>] Groups
      #
      def call
        res = client.get('/api/rest/v1/groups.json')

        res.map { |i| BrickFTP::Types::Group.new(i.symbolize_keys) }
      end
    end
  end
end
