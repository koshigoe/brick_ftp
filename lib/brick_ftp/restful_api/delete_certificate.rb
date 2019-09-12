# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete SSL Certificate
    #
    # @see https://developers.files.com/#delete-ssl-certificate Delete SSL Certificate
    #
    class DeleteCertificate
      include Command

      # Delete SSL Certificate
      #
      # @param [Integer] id SSL Certificate ID.
      #
      def call(id)
        client.delete("/api/rest/v1/certificates/#{id}.json")
        true
      end
    end
  end
end
