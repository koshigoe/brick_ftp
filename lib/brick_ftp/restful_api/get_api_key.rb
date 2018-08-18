# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    class GetAPIKey
      include Command

      # Returns a single API key.
      #
      # @param [Integer] id Globally unique identifier of each user API key.
      #   Each user API key is given an ID automatically upon creation.
      # @return [BrickFTP::Types::UserAPIKey] User's API key
      #
      def call(id)
        res = client.get("/api/rest/v1/api_keys/#{id}.json")

        BrickFTP::Types::UserAPIKey.new(res.symbolize_keys)
      end
    end
  end
end
