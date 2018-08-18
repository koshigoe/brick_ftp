# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    class DeleteGroup
      include Command

      # Deletes the specified group.
      #
      # @param [Integer] id Globally unique identifier of each group.
      #   Each group is given an ID automatically upon creation.
      #
      def call(id)
        client.delete("/api/rest/v1/groups/#{id}.json")
        true
      end
    end
  end
end
