# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Show an API key
    #
    # @see https://developers.files.com/#show-an-api-key Show an API key
    #
    class GetAPIKey
      include Command
      using BrickFTP::CoreExt::Hash

      # Returns a single API key.
      #
      # @param [Integer] id Globally unique identifier of each user API key.
      #   Each user API key is given an ID automatically upon creation.
      # @return [BrickFTP::Types::UserAPIKey] User's API key
      #
      def call(id)
        res = client.get("/api/rest/v1/api_keys/#{id}.json")

        BrickFTP::Types::UserAPIKey.new(**res.symbolize_keys)
      end
    end
  end
end
