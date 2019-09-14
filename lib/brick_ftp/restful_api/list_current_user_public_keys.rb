# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # List current user's SSH public keys
    #
    # @see https://developers.files.com/#list-current-user-39-s-ssh-public-keys List current user's SSH public keys
    #
    class ListCurrentUserPublicKeys
      include Command
      using BrickFTP::CoreExt::Hash

      # List current user's SSH public keys
      #
      # @return [Array<BrickFTP::Types::PublicKey>]
      #
      def call
        res = client.get('/api/rest/v1/user/public_keys.json')

        res.map { |i| BrickFTP::Types::PublicKey.new(i.symbolize_keys) }
      end
    end
  end
end
