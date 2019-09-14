# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete SSL Certificate
    #
    # @see https://developers.files.com/#delete-ssl-certificate Delete SSL Certificate
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Required: SSL Certificate ID.
    #
    class DeleteCertificate
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'DeleteCertificateParams',
        :id,
        keyword_init: true
      )

      # Delete SSL Certificate
      #
      # @param [BrickFTP::RESTfulAPI::DeleteCertificate::::Params] params parameters
      #
      def call(params)
        params = params.to_h.compact
        client.delete("/api/rest/v1/certificates/#{params.delete(:id)}.json")
        true
      end
    end
  end
end
