# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create a public key
    #
    # @see https://developers.brickftp.com/#create-a-public-key Create a public key
    #
    # ### Params
    #
    # PARAMETER  | TYPE    | DESCRIPTION
    # ---------- | ------- | -----------
    # title      | string  | Title to identify the public key. For your reference. Maximum of 50 characters.
    # public_key | string  | The public key itself. This property is write-only. It cannot be retrieved via the API.
    #
    class CreatePublicKey
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'CreatePublicKeyParams',
        :title,
        :public_key,
        keyword_init: true
      )

      # Creates a new public key for a user on the current site.
      #
      # @param [Integer] id Globally unique identifier of each user.
      #   Each user is given an ID automatically upon creation.
      # @param [BrickFTP::RESTfulAPI::CreatePublicKey::Params] params parameters for creating an Public key
      # @return [BrickFTP::Types::UserPublicKey] User's Public key
      #
      def call(id, params)
        res = client.post("/api/rest/v1/users/#{id}/public_keys.json", params.to_h.compact)

        BrickFTP::Types::UserPublicKey.new(res.symbolize_keys)
      end
    end
  end
end
