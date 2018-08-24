# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete a public key
    #
    # @see https://developers.brickftp.com/#delete-a-public-key Delete a public key
    #
    class DeletePublicKey
      include Command

      # Deletes the specified public key.
      #
      # @param [Integer] id Globally unique identifier of each public key.
      #   Each public key is given an ID automatically upon creation.
      #
      def call(id)
        client.delete("/api/rest/v1/public_keys/#{id}.json")
        true
      end
    end
  end
end
