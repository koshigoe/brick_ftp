# frozen_string_literal: true

require 'brick_ftp/commands/restful'

module BrickFTP
  module Commands
    class UnlockUser
      include RESTful

      # Unlocks a user that has been locked out by Brute Force Login Protection.
      #
      # @param [Integer] id Globally unique identifier of each user.
      #   Each user is given an ID automatically upon creation.
      # @return [BrickFTP::Types::User, nil] unlocked User or nil
      #
      def call(id:)
        res = client.post("/api/rest/v1/users/#{id}/unlock.json")

        BrickFTP::Types::User.new(res.symbolize_keys)
      end
    end
  end
end
