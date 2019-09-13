# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # List groups
    #
    # @see https://developers.files.com/#list-groups List groups
    #
    class ListGroups
      include Command
      using BrickFTP::CoreExt::Hash

      # List groups
      #
      # @return [Array<BrickFTP::Types::Group>]
      #
      def call
        res = client.get('/api/rest/v1/groups.json')

        res.map { |i| BrickFTP::Types::Group.new(i.symbolize_keys) }
      end
    end
  end
end
