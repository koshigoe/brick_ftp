# frozen_string_literal: true

require 'brick_ftp/commands/restful'

module BrickFTP
  module Commands
    class DeleteUser
      include RESTful

      # Deletes the specified user.
      #
      # For additional security, this method requires reauthentication when updating a password unless an API key is used.
      #
      # @param [Integer] id Globally unique identifier of each user.
      #   Each user is given an ID automatically upon creation.
      #
      def call(id:)
        client.delete("/api/rest/v1/users/#{id}.json")
        true
      end
    end
  end
end
