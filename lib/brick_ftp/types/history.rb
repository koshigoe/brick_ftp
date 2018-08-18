# frozen_string_literal: true

module BrickFTP
  module Types
    # rubocop:disable Metrics/LineLength, Layout/CommentIndentation
    History = Struct.new(
      'History',
      :id,           # integer  | Globally unique identifier of each history entry.
      :when,         # datetime | Date of the history entry.
      :user_id,      # integer  | ID of the user associated with the history entry.
      :username,     # string   | Username of the user associated with the history entry.
      :action,       # string   | Type of action that occurred.
                     #          | Will be one of the following:
                     #          |   create, read, update, destroy, move, login, failedlogin, copy, user_create, user_destroy, group_create, group_destroy, permission_create, permission_destroy.
      :failure_type, # string   | Type of failure that occurred, if any.
      :path,         # string   | Path of the file or folder associated with the history entry.
      :source,       # string   | Source path associated with the history entry.
      :destination,  # string   | Destination path associated with the history entry.
      :targets,      # object   | Object containing the target object(s) for user_create, user_destroy, group_create, group_destroy, permission_create, and permission_destroy actions.
                     #          | A user target will include an id and username. A group target will include an id and name. A permission target will include an id, permission, and a recursive parameter.
      :ip,           # string   | IP address associated with the history entry.
      :interface,    # string   | Interface associated with the history entry. Will be one of the following: web, ftp, robot, jsapi, restapi, sftp, dav.
      keyword_init: true
    )
    # rubocop:enable Metrics/LineLength, Layout/CommentIndentation
  end
end
