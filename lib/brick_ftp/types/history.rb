# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # The notification object
    #
    # @see https://developers.brickftp.com/#the-notification-object The notification object
    #
    # ATTRIBUTE     | TYPE     | DESCRIPTION
    # ------------- | -------- | -----------
    # id            | integer  | Globally unique identifier of each history entry.
    # when          | datetime | Date of the history entry.
    # user_id       | integer  | ID of the user associated with the history entry.
    # username      | string   | Username of the user associated with the history entry.
    # action        | string   | Type of action that occurred. Will be one of the following: <br>`create`, `read`, `update`, `destroy`, `move`, `login`, `failedlogin`, `copy`, `user_create`, `user_destroy`, `group_create`, `group_destroy`, `permission_create`, `permission_destroy`.
    # failure_type  | string   | Type of failure that occurred, if any.
    # path          | string   | Path of the file or folder associated with the history entry.
    # source        | string   | Source path associated with the history entry.
    # destination   | string   | Destination path associated with the history entry.
    # targets       | object   | Object containing the target object(s) for `user_create`, `user_destroy`, `group_create`, `group_destroy`, `permission_create`, and `permission_destroy` actions. <br>A `user` target will include an `id` and `username`. A `group` target will include an `id` and `name`. A `permission` target will include an `id`, `permission`, and a `recursive` parameter.
    # ip            | string   | IP address associated with the history entry.
    # interface     | string   | Interface associated with the history entry. Will be one of the following: web, ftp, robot, jsapi, restapi, sftp, dav.
    #
    History = Struct.new(
      'History',
      :id,
      :when,
      :user_id,
      :username,
      :action,
      :failure_type,
      :path,
      :source,
      :destination,
      :targets,
      :ip,
      :interface,
      keyword_init: true
    )
  end
end
