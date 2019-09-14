# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create notification
    #
    # @see https://developers.files.com/#create-notification Create notification
    #
    # ### Params
    #
    # PARAMETER           | TYPE    | DESCRIPTION
    # ------------------- | ------- | -----------
    # group_id            | integer | The ID of the group to notify. Provide user_id, username or group_id.
    # notify_on_copy      | boolean | If true, copying or moving resources into this path will trigger a notification, in addition to just uploads.
    # notify_user_actions | boolean | If true actions initiated by the user will still result in a notification
    # path                | string  | Path
    # send_interval       | string  | The time interval that notifications are aggregated by. Can be five_minutes, fifteen_minutes, hourly, or daily.
    # user_id             | integer | The id of the user to notify. Provide user_id, username or group_id.
    # username            | string  | The username of the user to notify. Provide user_id, username or group_id.
    #
    class CreateNotification
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'CreateNotificationParams',
        :group_id,
        :notify_on_copy,
        :notify_user_actions,
        :path,
        :send_interval,
        :user_id,
        :username,
        keyword_init: true
      )

      # Create notification
      #
      # @param [BrickFTP::RESTfulAPI::CreateNotification::Params] params parameters
      # @return [BrickFTP::Types::Notification]
      #
      def call(params)
        res = client.post('/api/rest/v1/notifications.json', Params.new(params.to_h).to_h.compact)

        BrickFTP::Types::Notification.new(res.symbolize_keys)
      end
    end
  end
end
