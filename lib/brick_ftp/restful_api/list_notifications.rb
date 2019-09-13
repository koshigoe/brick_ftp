# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # List notifications
    #
    # @see https://developers.files.com/#list-notifications List notifications
    #
    class ListNotifications
      include Command
      using BrickFTP::CoreExt::Hash

      # List notifications
      #
      # @return [Array<BrickFTP::Types::Notification>]
      #
      def call
        res = client.get('/api/rest/v1/notifications.json')

        res.map { |i| BrickFTP::Types::Notification.new(i.symbolize_keys) }
      end
    end
  end
end
