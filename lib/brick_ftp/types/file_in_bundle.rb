# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # @see https://developers.files.com/#download-one-file-in-a-bundle Download one file in a bundle
    #
    # ATTRIBUTE    | TYPE     | DESCRIPTION
    # ------------ | -------- | -----------
    # path         | string   | undocumented
    # type         | string   | undocumented
    # size         | integer  | undocumented
    # download_uri | string   | undocumented
    #
    FileInBundle = Struct.new(
      'FileInBundle',
      :path,
      :type,
      :size,
      :download_uri,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
