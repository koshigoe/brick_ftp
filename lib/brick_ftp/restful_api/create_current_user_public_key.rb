# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create SSH public key on current user
    #
    # @see https://developers.files.com/#create-ssh-public-key-on-current-user Create SSH public key on current user
    #
    class CreateCurrentUserPublicKey
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER  | TYPE    | DESCRIPTION
      # ---------- | ------- | -----------
      # title      | string  | Required: Internal reference for key.
      # public_key | string  | Required: Actual contents of SSH key.
      Params = Struct.new(
        'CreateCurrentUserPublicKeyParams',
        :title,
        :public_key,
        keyword_init: true
      )

      # Create SSH public key on current user
      #
      # @param [BrickFTP::RESTfulAPI::CreateCurrentUserPublicKey::Params] params parameters
      # @return [BrickFTP::Types::PublicKey]
      #
      def call(params = {})
        res = client.post('/api/rest/v1/user/public_keys.json', Params.new(params.to_h).to_h.compact)

        BrickFTP::Types::PublicKey.new(res.symbolize_keys)
      end
    end
  end
end
