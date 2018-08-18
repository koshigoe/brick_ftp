# frozen_string_literal: true

module BrickFTP
  module Types
    FileInBundle = Struct.new(
      'FileInBundle',
      :path,         # string
      :type,         # string
      :size,         # integer
      :download_uri, # string
      keyword_init: true
    )
  end
end
