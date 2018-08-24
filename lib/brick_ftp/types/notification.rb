# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # The notification object
    #
    # @see https://developers.brickftp.com/#the-notification-object The notification object
    #
    # ATTRIBUTE     | TYPE    | DESCRIPTION
    # ------------- | ------- | -----------
    # id            | integer | Globally unique identifier of each notification. Each notification is given an ID automatically upon creation.
    # path          | string  | Folder path for notifications. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # user_id       | integer | Unique identifier for the user being notified. Each user is given an ID automatically upon creation. You can look up user IDs by using the User resource of this REST API.
    # username      | string  | Username for the user given by user_id. If this value is set during creation and user_id is not set, the user_id is looked up from the username and set. Maximum of 50 characters.
    # send_interval | string  | The send interval for notifications. Can be one of the following: five_minutes (default), fifteen_minutes, hourly, daily.
    # unsubscribed  | boolean | If true, the user has unsubscribed from receiving this notification. This property is read-only.
    #
    Notification = Struct.new(
      'Notification',
      :id,
      :path,
      :user_id,
      :username,
      :send_interval,
      :unsubscribed,
      keyword_init: true
    )
  end
end
