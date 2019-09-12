# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # The History object
    #
    # @see https://developers.files.com/#the-history-object The History object
    #
    # ATTRIBUTE     | TYPE     | DESCRIPTION
    # ------------- | -------- | -----------
    # id            | integer  | Action ID
    # when          | datetime | Action occurrence date/time
    # destination   | string   | The destination path for this action, if applicable
    # display       | string   | Display format
    # ip            | string   | IP Address that performed this action
    # path          | string   | Path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # source        | string   | The source path for this action, if applicable
    # targets       | array    | Targets
    # user_id       | integer  | User ID
    # username      | string   | Username
    # action        | string   | Type of action. Can be `create`, `read`, `update`, `destroy`, `move`, `login`, `failedlogin`, `copy`, `user_create`, `user_update`, `user_destroy`, `group_create`, `group_update`, `group_destroy`, `permission_create`, `permission_destroy`, `api_key_create`, `api_key_update`, or `api_key_destroy`
    # failure_type  | string   |Failure type. If action was a user login or session failure, why did it fail? Can be `expired_trial`, `account_overdue`, `locked_out`, `ip_mismatch`, `password_mismatch`, `site_mismatch`, `username_not_found`, `none`, `no_ftp_permission`, `no_web_permission`, `no_directory`, `errno_enoent`, `no_sftp_permission`, `no_dav_permission`, `no_restapi_permission`, `key_mismatch`, `region_mismatch`, or `expired_access`
    # interface     | string   | Interface on which this action occurred.
    #
    History = Struct.new(
      'History',
      :id,
      :when,
      :destination,
      :display,
      :ip,
      :path,
      :source,
      :targets,
      :user_id,
      :username,
      :action,
      :failure_type,
      :interface,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
