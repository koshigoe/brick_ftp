# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # List bundles
    #
    # @see https://developers.files.com/#list-bundles List bundles
    #
    class ListBundles
      include Command
      using BrickFTP::CoreExt::Hash

      # List bundles
      #
      # @return [Array<BrickFTP::Types::Bundle>]
      #
      def call
        res = client.get('/api/rest/v1/bundles.json')

        res.map { |i| BrickFTP::Types::Bundle.new(i.symbolize_keys) }
      end
    end
  end
end
