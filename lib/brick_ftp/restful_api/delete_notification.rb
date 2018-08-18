# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    class DeleteNotification
      include Command

      # Deletes the specified notification.
      #
      # @param [Integer] id Globally unique identifier of each notification.
      #   Each notification is given an ID automatically upon creation.
      #
      def call(id)
        client.delete("/api/rest/v1/notifications/#{id}.json")
        true
      end
    end
  end
end
