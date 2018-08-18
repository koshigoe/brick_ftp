# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    class CreateNotification
      include Command

      # rubocop:disable Metrics/LineLength
      Params = Struct.new(
        'CreateNotificationParams',
        :path,          # string  | Folder path for notifications. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
        :user_id,       # integer | Unique identifier for the user being notified. Each user is given an ID automatically upon creation. You can look up user IDs by using the User resource of this REST API.
        :username,      # string  | Username for the user given by user_id. If this value is set during creation and user_id is not set, the user_id is looked up from the username and set. Maximum of 50 characters.
        :send_interval, # string  | The send interval for notifications. Can be one of the following: five_minutes (default), fifteen_minutes, hourly, daily.
        keyword_init: true
      )
      # rubocop:enable Metrics/LineLength

      # Creates a new notification on the current site.
      #
      # @param [BrickFTP::RESTfulAPI::CreateNotification::Params] params parameters
      # @return [BrickFTP::Types::Notification] Notification
      #
      def call(params)
        res = client.post('/api/rest/v1/notifications.json', params.to_h.compact)

        BrickFTP::Types::Notification.new(res.symbolize_keys)
      end
    end
  end
end
