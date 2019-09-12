# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Activate SSL Certificate
    #
    # @see https://developers.files.com/#activate-ssl-certificate Activate SSL Certificate
    #
    # ### Params
    #
    # PARAMETER    | TYPE    | DESCRIPTION
    # ------------ | ------- | -----------
    # id           | integer | Required: SSL Certificate ID.
    # replace_cert | string  | Leave blank, set to `any` or `new_ips`.
    #
    class ActivateCertificate
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'ActivateCertificateParams',
        :replace_cert,
        keyword_init: true
      )

      # Activate SSL Certificate
      #
      # @param [Integer] id SSL Certificate ID.
      # @param [BrickFTP::RESTfulAPI::CreateCertificate::Params] params parameters
      # @return [Boolean]
      #
      def call(id, params)
        client.post("/api/rest/v1/certificates/#{id}/activate.json", params.to_h.compact)
        true
      end
    end
  end
end
