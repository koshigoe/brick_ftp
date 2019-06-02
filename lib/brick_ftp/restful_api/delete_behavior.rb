# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete a behavior
    #
    # @see https://developers.files.com/#delete-a-behavior Delete a behavior
    #
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
