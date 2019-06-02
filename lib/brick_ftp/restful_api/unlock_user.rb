# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Unlock a user
    #
    # @see https://developers.files.com/#unlock-a-user Unlock a user
    #
    class UnlockUser
      include Command
      using BrickFTP::CoreExt::Hash

      # Unlocks a user that has been locked out by Brute Force Login Protection.
      #
      # @param [Integer] id Globally unique identifier of each user.
      #   Each user is given an ID automatically upon creation.
      # @return [BrickFTP::Types::User, nil] unlocked User or nil
      #
      def call(id)
        res = client.post("/api/rest/v1/users/#{id}/unlock.json")

        BrickFTP::Types::User.new(res.symbolize_keys)
      end
    end
  end
end
