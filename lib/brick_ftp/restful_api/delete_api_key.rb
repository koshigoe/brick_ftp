# frozen_string_literal: true

require 'brick_ftp/restful_api/restful'

module BrickFTP
  module RESTfulAPI
    class DeleteAPIKey
      include RESTful

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
