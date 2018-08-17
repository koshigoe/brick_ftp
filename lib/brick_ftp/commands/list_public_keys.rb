# frozen_string_literal: true

require 'brick_ftp/commands/restful'

module BrickFTP
  module Commands
    class ListPublicKeys
      include RESTful

      # Returns a list of all public keys for a user on the current site.
      #
      # @param [Integer] id Globally unique identifier of each user.
      #   Each user is given an ID automatically upon creation.
      # @return [Array<BrickFTP::Types::UserPublicKey>] User's Public keys
      #
      def call(id)
        res = client.get("/api/rest/v1/users/#{id}/public_keys.json")

        res.map { |i| BrickFTP::Types::UserPublicKey.new(i.symbolize_keys) }
      end
    end
  end
end
