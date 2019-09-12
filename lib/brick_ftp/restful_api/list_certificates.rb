# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # List SSL Certificates
    #
    # @see https://developers.files.com/#list-ssl-certificates List SSL Certificates
    #
    class ListCertificates
      include Command
      using BrickFTP::CoreExt::Hash

      # List SSL Certificates
      #
      # @return [Array<BrickFTP::Types::Certificate>]
      #
      def call
        res = client.get('/api/rest/v1/certificates.json')

        res.map { |i| BrickFTP::Types::Certificate.new(i.symbolize_keys) }
      end
    end
  end
end
