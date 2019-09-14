# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete user session (log out)
    #
    # @see https://developers.files.com/#delete-user-session-log-out Delete user session (log out)
    #
    class DeleteSession
      include Command

      # Delete user session (log out)
      #
      def call
        client.delete('/api/rest/v1/sessions.json')
        true
      end
    end
  end
end
