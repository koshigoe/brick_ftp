# frozen_string_literal: true

module BrickFTP
  module Types
    BundleZip = Struct.new(
      'BundleZip',
      :download_uri, # string
      keyword_init: true
    )
  end
end
