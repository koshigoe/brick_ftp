# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Show a public key
    #
    # @see https://developers.brickftp.com/#show-a-public-key Show a public key
    #
    class GetPublicKey
      include Command
      using BrickFTP::CoreExt::Hash

      # Returns a single public key.
      #
      # @param [Integer] id Globally unique identifier of each public key.
      #   Each public key is given an ID automatically upon creation.
      # @return [BrickFTP::Types::UserPublicKey] User's Public key
      #
      def call(id)
        res = client.get("/api/rest/v1/public_keys/#{id}.json")

        BrickFTP::Types::UserPublicKey.new(res.symbolize_keys)
      end
    end
  end
end
