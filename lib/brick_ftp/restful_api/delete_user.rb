# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete a user
    #
    # @see https://developers.files.com/#delete-a-user Delete a user
    #
    class DeleteUser
      include Command

      # Deletes the specified user.
      #
      # For additional security, this method requires reauthentication when updating a password unless an API key is used.
      #
      # @param [Integer] id Globally unique identifier of each user.
      #   Each user is given an ID automatically upon creation.
      #
      def call(id)
        client.delete("/api/rest/v1/users/#{id}.json")
        true
      end
    end
  end
end
