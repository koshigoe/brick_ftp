# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # @see https://developers.brickftp.com/#download-entire-bundle-as-zip Download entire bundle as ZIP
    #
    # ATTRIBUTE    | TYPE     | DESCRIPTION
    # ------------ | -------- | -----------
    # download_uri | string   | undocumented
    #
    BundleZip = Struct.new(
      'BundleZip',
      :download_uri,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
