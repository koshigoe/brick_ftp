# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete SSH public key
    #
    # @see https://developers.files.com/#delete-ssh-public-key Delete SSH public key
    #
    class DeletePublicKey
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'DeletePublicKeyParams',
        :id,
        keyword_init: true
      )

      # Delete SSH public key
      #
      # @param [BrickFTP::RESTfulAPI::DeletePublicKey::Params] params parameters
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        client.delete("/api/rest/v1/public_keys/#{params.delete(:id)}.json")
        true
      end
    end
  end
end
