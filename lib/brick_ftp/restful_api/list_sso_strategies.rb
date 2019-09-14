# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # List SSO strategies
    #
    # @see https://developers.files.com/#list-sso-strategies List SSO strategies
    #
    class ListSsoStrategies
      include Command
      using BrickFTP::CoreExt::Hash

      # List SSO strategies
      #
      # @return [Array<BrickFTP::Types::SsoStrategy>]
      #
      def call
        res = client.get('/api/rest/v1/sso_strategies.json')

        res.map { |i| BrickFTP::Types::SsoStrategy.new(i.symbolize_keys) }
      end
    end
  end
end
