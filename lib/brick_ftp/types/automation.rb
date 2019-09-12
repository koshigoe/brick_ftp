# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # ## The Automation object
    #
    # @see https://developers.files.com/#the-automation-object The Automation object
    #
    # ATTRIBUTE                | TYPE     | DESCRIPTION
    # ------------------------ | -------- | -----------
    # id                       | integer  | Automation ID
    # automation               | string   | Automation type. One of: `create_folder`, `request_file`, `request_move`
    # source                   | string   | Source Path
    # destination              | string   | Destination Path
    # destination_replace_from | string   | If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
    # destination_replace_to   | string   | If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
    # interval                 | string   | How often to run this automation? One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
    # next_process_on          | string   | Date this automation will next run.
    # path                     | string   | Path on which this Automation runs. Supports globs. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # realtime                 | boolean  | Does this automation run in real time? This is a read-only property based on automation type.
    # user_id                  | integer  | User ID of the Automation's creator.
    # user_ids                 | array    | IDs of Users for the Automation (i.e. who to Request File from)
    # group_ids                | array    | IDs of Groups for the Automation (i.e. who to Request File from)
    #
    Automation = Struct.new(
      'Automation',
      :id,
      :automation,
      :source,
      :destination,
      :destination_replace_from,
      :destination_replace_to,
      :interval,
      :next_process_on,
      :path,
      :realtime,
      :user_id,
      :user_ids,
      :group_ids,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
