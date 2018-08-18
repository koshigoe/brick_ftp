# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    class GetBundle
      include Command

      # Returns a single bundle.
      #
      # @param [Integer] id Globally unique identifier of each bundle.
      # @return [BrickFTP::Types::Bundle] Bundle
      #
      def call(id)
        res = client.get("/api/rest/v1/bundles/#{id}.json")
        return nil if !res || res.empty?

        BrickFTP::Types::Bundle.new(res.symbolize_keys)
      end
    end
  end
end
