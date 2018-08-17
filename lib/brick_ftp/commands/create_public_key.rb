# frozen_string_literal: true

require 'brick_ftp/commands/restful'

module BrickFTP
  module Commands
    class CreatePublicKey
      include RESTful

      Params = Struct.new(
        'CreatePublicKeyParams',
        :title,       # string   | Title to identify the public key. For your reference. Maximum of 50 characters.
        :public_key,  # string   | The public key itself. This property is write-only. It cannot be retrieved via the API.
        keyword_init: true
      )

      # Creates a new public key for a user on the current site.
      #
      # @param [Integer] id Globally unique identifier of each user.
      #   Each user is given an ID automatically upon creation.
      # @param [BrickFTP::Commands::CreatePublicKey::Params] params parameters for creating an Public key
      # @return [BrickFTP::Types::UserPublicKey] User's Public key
      #
      def call(id, params)
        res = client.post("/api/rest/v1/users/#{id}/public_keys.json", params.to_h.compact)

        BrickFTP::Types::UserPublicKey.new(res.symbolize_keys)
      end
    end
  end
end
