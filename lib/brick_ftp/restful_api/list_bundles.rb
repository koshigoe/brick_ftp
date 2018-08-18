# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    class ListBundles
      include Command

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
