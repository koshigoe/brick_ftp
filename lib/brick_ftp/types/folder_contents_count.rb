# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # @see https://developers.files.com/#count-folder-contents-recursively Count folder contents recursively
    # @see https://developers.files.com/#count-folder-contents-non-recursively Count folder contents non-recursively
    #
    # ATTRIBUTE  | TYPE    | DESCRIPTION
    # ---------- | ------- | -----------
    # total      | integer | undocumented
    # files      | integer | undocumented
    # folders    | integer | undocumented
    #
    FolderContentsCount = Struct.new(
      'FolderContentsCount',
      :total,
      :files,
      :folders,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
