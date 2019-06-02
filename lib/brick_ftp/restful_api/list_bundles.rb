# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # List all bundles
    #
    # @see https://developers.files.com/#list-all-bundles List all bundles
    #
    class ListBundles
      include Command
      using BrickFTP::CoreExt::Hash

      # Returns a list of all bundles on the current site.
      #
      # @return [Array<BrickFTP::Types::Bundle>] Bundle
      #
      def call
        res = client.get('/api/rest/v1/bundles.json')

        res.map { |i| BrickFTP::Types::Bundle.new(i.symbolize_keys) }
      end
    end
  end
end
