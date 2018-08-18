# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    class DeleteBehavior
      include Command

      # Deletes a behavior.
      #
      # @param [Integer] id Globally unique identifier of each behavior.
      #
      def call(id)
        client.delete("/api/rest/v1/behaviors/#{id}.json")
        true
      end
    end
  end
end
