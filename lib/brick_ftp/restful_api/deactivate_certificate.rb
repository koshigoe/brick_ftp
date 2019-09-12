# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Deactivate SSL Certificate
    #
    # @see https://developers.files.com/#deactivate-ssl-certificate Deactivate SSL Certificate
    #
    class DeactivateCertificate
      include Command
      using BrickFTP::CoreExt::Hash

      # Deactivate SSL Certificate
      #
      # @param [Integer] id SSL Certificate ID.
      # @return [Boolean]
      #
      def call(id)
        client.post("/api/rest/v1/certificates/#{id}/deactivate.json")
        true
      end
    end
  end
end
