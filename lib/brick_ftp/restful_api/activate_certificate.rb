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
        :id,
        :replace_cert,
        keyword_init: true
      )

      # Activate SSL Certificate
      #
      # @param [BrickFTP::RESTfulAPI::CreateCertificate::Params] params parameters
      # @return [Boolean]
      #
      def call(params)
        params = params.to_h.compact
        client.post("/api/rest/v1/certificates/#{params.delete(:id)}/activate.json", params)
        true
      end
    end
  end
end
