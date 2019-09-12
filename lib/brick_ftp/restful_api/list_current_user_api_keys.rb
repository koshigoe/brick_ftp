# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # List current user's API Keys
    #
    # @see https://developers.files.com/#list-current-user-39-s-api-keys List current user's API Keys
    #
    class ListCurrentUserApiKeys
      include Command
      using BrickFTP::CoreExt::Hash

      # List current user's API Keys
      #
      # @return [Array<BrickFTP::Types::ApiKey>]
      #
      def call
        res = client.get('/api/rest/v1/user/api_keys.json')

        res.map { |i| BrickFTP::Types::ApiKey.new(i.symbolize_keys) }
      end
    end
  end
end
