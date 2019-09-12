# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete current API key. (Requires current API connection to be using an API key.)
    #
    # @see https://developers.files.com/#delete-current-api-key-requires-current-api-connection-to-be-using-an-api-key Delete current API key. (Requires current API connection to be using an API key.)
    #
    class DeleteCurrentAPIKey
      include Command

      # Delete current API key. (Requires current API connection to be using an API key.)
      #
      def call
        client.delete('/api/rest/v1/api_key.json')
        true
      end
    end
  end
end
