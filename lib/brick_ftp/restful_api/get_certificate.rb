# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Show SSL Certificate
    #
    # @see https://developers.files.com/#show-ssl-certificate Show SSL Certificate
    #
    class GetCertificate
      include Command
      using BrickFTP::CoreExt::Hash

      # Show SSL Certificate
      #
      # @param [Integer] id SSL Certificate ID.
      # @return [BrickFTP::Types::Certificate]
      #
      def call(id)
        res = client.get("/api/rest/v1/certificates/#{id}.json")
        return nil if !res || res.empty?

        BrickFTP::Types::Certificate.new(res.symbolize_keys)
      end
    end
  end
end
