# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete an API key
    #
    # @see https://developers.brickftp.com/#delete-an-api-key Delete an API key
    #
    class DeleteAPIKey
      include Command

      # Deletes the specified API key.
      #
      # @param [Integer] id Globally unique identifier of each user API key.
      #   Each user API key is given an ID automatically upon creation.
      #
      def call(id)
        client.delete("/api/rest/v1/api_keys/#{id}.json")
        true
      end
    end
  end
end
