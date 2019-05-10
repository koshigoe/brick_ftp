# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Show a group
    #
    # @see https://developers.files.com/#show-a-group Show a group
    #
    class GetGroup
      include Command
      using BrickFTP::CoreExt::Hash

      # Returns a single group.
      #
      # @param [Integer] id Globally unique identifier of each group.
      #   Each group is given an ID automatically upon creation.
      # @return [BrickFTP::Types::Group, nil] found Group or nil
      #
      def call(id)
        res = client.get("/api/rest/v1/groups/#{id}.json")
        return nil if !res || res.empty?

        BrickFTP::Types::Group.new(res.symbolize_keys)
      end
    end
  end
end
