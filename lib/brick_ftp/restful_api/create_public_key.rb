# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create SSH public key on a user
    #
    # @see https://developers.files.com/#create-ssh-public-key-on-a-user Create SSH public key on a user
    #
    class CreatePublicKey
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER  | TYPE    | DESCRIPTION
      # ---------- | ------- | -----------
      # id         | integer | Required: User ID.
      # title      | string  | Required: Internal reference for key.
      # public_key | string  | Required: Actual contents of SSH key.
      Params = Struct.new(
        'CreatePublicKeyParams',
        :id,
        :title,
        :public_key,
        keyword_init: true
      )

      # Create SSH public key on a user
      #
      # @param [BrickFTP::RESTfulAPI::CreatePublicKey::Params] params parameters
      # @return [BrickFTP::Types::PublicKey]
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        res = client.post("/api/rest/v1/users/#{params.delete(:id)}/public_keys.json", params)

        BrickFTP::Types::PublicKey.new(res.symbolize_keys)
      end
    end
  end
end
