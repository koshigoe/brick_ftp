# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # The Style object
    #
    # @see https://developers.files.com/#the-style-object The Style object
    #
    # ATTRIBUTE | TYPE   | DESCRIPTION
    # --------- | ------ | -----------
    # logo      | ?      | Logo
    # path      | string | Folder path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # thumbnail | ?      | Logo thumbnail
    #
    Style = Struct.new(
      'Style',
      :logo,
      :path,
      :thumbnail,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
