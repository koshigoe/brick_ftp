# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Show SSH public key
    #
    # @see https://developers.files.com/#show-ssh-public-key Show SSH public key
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Required: SSH public key ID.
    #
    class GetPublicKey
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'GetPublicKeyParams',
        :id,
        keyword_init: true
      )

      # Show SSH public key
      #
      # @param [BrickFTP::RESTfulAPI::GetPublicKey::Params] params parameters
      # @return [BrickFTP::Types::PublicKey]
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        res = client.get("/api/rest/v1/public_keys/#{params.delete(:id)}.json")

        BrickFTP::Types::PublicKey.new(res.symbolize_keys)
      end
    end
  end
end
