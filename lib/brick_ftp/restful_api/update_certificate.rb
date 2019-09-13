# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Update SSL Certificate
    #
    # @see Update SSL Certificate
    #
    # ### Params
    #
    # PARAMETER     | TYPE    | DESCRIPTION
    # ------------- | ------- | -----------
    # id            | integer | Required: SSL Certificate ID.
    # name          | string  | Internal certificate name.
    # intermediates | string  | Any intermediate certificates. PEM or PKCS7 formats accepted.
    # certificate   | string  | The certificate. PEM or PKCS7 formats accepted.
    #
    class UpdateCertificate
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'UpdateCertificateParams',
        :name,
        :intermediates,
        :certificate,
        keyword_init: true
      )

      # Update SSL Certificate
      #
      # @param [Integer] id SSL Certificate ID.
      # @param [BrickFTP::RESTfulAPI::UpdateCertificate::Params] params parameters
      # @return [BrickFTP::Types::Certificate]
      #
      def call(id, params)
        res = client.patch("/api/rest/v1/certificates/#{id}.json", params.to_h.compact)

        BrickFTP::Types::Certificate.new(res.symbolize_keys)
      end
    end
  end
end