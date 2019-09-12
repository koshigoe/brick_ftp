# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # The Notification object
    #
    # @see https://developers.files.com/#the-notification-object The Notification object
    #
    # ATTRIBUTE           | TYPE    | DESCRIPTION
    # ------------------- | ------- | -----------
    # id                  | integer | Notification ID
    # group_id            | integer | Notification group id
    # group_name          | string  | Group name if applicable
    # notify_user_actions | boolean | Trigger notification on notification user actions?
    # notify_on_copy      | boolean | Triggers notification when moving or copying files to this path
    # path                | string  | Folder path to notify on This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # send_interval       | string  | The time interval that notifications are aggregated to. Can be five_minutes, fifteen_minutes, hourly, or daily
    # unsubscribed        | boolean | Is the user unsubscribed from this notification?
    # unsubscribed_reason | string  | The reason that the user unsubscribed. Can be none, unsubscribe_link_clicked, mail_bounced, or mail_marked_as_spam.
    # user_id             | integer | Notification user ID
    # username            | string  | Notification username
    #
    Notification = Struct.new(
      'Notification',
      :id,
      :group_id,
      :group_name,
      :notify_user_actions,
      :notify_on_copy,
      :path,
      :send_interval,
      :unsubscribed,
      :unsubscribed_reason,
      :user_id,
      :username,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
