# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # ## The behavior object
    #
    # @see https://developers.brickftp.com/#the-behavior-object The behavior object
    #
    # ATTRIBUTE  | TYPE     | DESCRIPTION
    # ---------- | -------- | -----------
    # id         | integer  | Globally unique identifier of each behavior.
    # path       | string   | Folder path for behaviors. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # behavior   | string   | The behavior type. Can be one of the following: webhook, file_expiration, auto_encrypt, lock_subfolders.
    # value      | array    | Array of values associated with the behavior.
    #
    Behavior = Struct.new(
      'Behavior',
      :id,
      :path,
      :behavior,
      :value,
      keyword_init: true
    )
  end
end
