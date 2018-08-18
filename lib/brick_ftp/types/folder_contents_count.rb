# frozen_string_literal: true

module BrickFTP
  module Types
    FolderContentsCount = Struct.new(
      'FolderContentsCount',
      :total,
      :files,
      :folders,
      keyword_init: true
    )
  end
end
