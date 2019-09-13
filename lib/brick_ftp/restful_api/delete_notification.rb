# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete notification
    #
    # @see https://developers.files.com/#delete-notification Delete notification
    #
    class DeleteNotification
      include Command

      # Delete notification
      #
      # @param [Integer] id Notification ID.
      #
      def call(id)
        client.delete("/api/rest/v1/notifications/#{id}.json")
        true
      end
    end
  end
end
