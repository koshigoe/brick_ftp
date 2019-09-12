# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # ## The behavior object
    #
    # @see https://developers.files.com/#the-behavior-object The Behavior object
    #
    # ATTRIBUTE  | TYPE     | DESCRIPTION
    # ---------- | -------- | -----------
    # id         | integer  | Folder behavior ID
    # behavior   | string   | Behavior type.
    # path       | string   | Folder path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # value      | object   | Settings for this behavior. See the section above for an example value to provide here. Formatting is different for each Behavior type. May be sent as nested JSON or a single JSON-encoded string. If using XML encoding for the API call, this data must be sent as a JSON-encoded string.
    #
    Behavior = Struct.new(
      'Behavior',
      :id,
      :path,
      :behavior,
      :value,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
