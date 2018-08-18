# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    class ListNotifications
      include Command

      # Returns a list of all notifications on the current site.
      #
      # @return [Array<BrickFTP::Types::Notification>] Notifications
      #
      def call
        res = client.get('/api/rest/v1/notifications.json')

        res.map { |i| BrickFTP::Types::Notification.new(i.symbolize_keys) }
      end
    end
  end
end
