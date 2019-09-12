# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Show bundle
    #
    # @see https://developers.files.com/#show-bundle Show bundle
    #
    class GetBundle
      include Command
      using BrickFTP::CoreExt::Hash

      # Show bundle
      #
      # @param [Integer] id Bundle ID.
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
