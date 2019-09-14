# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Show SSL Certificate
    #
    # @see https://developers.files.com/#show-ssl-certificate Show SSL Certificate
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Required: SSL Certificate ID.
    #
    class GetCertificate
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'GetCertificateParams',
        :id,
        keyword_init: true
      )

      # Show SSL Certificate
      #
      # @param [BrickFTP::RESTfulAPI::GetCertificate::Params] params parameters
      # @return [BrickFTP::Types::Certificate]
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        res = client.get("/api/rest/v1/certificates/#{params.delete(:id)}.json")
        return nil if !res || res.empty?

        BrickFTP::Types::Certificate.new(res.symbolize_keys)
      end
    end
  end
end
