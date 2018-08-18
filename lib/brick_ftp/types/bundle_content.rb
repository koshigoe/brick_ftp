# frozen_string_literal: true

module BrickFTP
  module Types
    BundleContent = Struct.new(
      'BundleContent',
      :path, # string
      :type, # string
      :size, # integer
      keyword_init: true
    )
  end
end
