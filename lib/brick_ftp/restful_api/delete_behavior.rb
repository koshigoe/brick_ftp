# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete behavior
    #
    # @see https://developers.files.com/#delete-behavior Delete behavior
    #
    class DeleteBehavior
      include Command

      # Delete behavior
      #
      # @param [Integer] id Folder behavior ID.
      #
      def call(id)
        client.delete("/api/rest/v1/behaviors/#{id}.json")
        true
      end
    end
  end
end
