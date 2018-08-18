# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    class CountFolderContents
      include Command

      # Returns number of files and folders.
      #
      # - Returns the combined total number of files and subfolders in a given folder recursively.
      # - Returns the number of files and folders, separately, located inside a given folder (non-recursively).
      #
      # @param [String] path
      # @param [Boolean] recursive
      # @return [BrickFTP::Types::FolderContentsCount] count
      #
      def call(path, recursive: false)
        action = recursive ? 'count' : 'count_nrs'
        res = client.get("/api/rest/v1/folders/#{ERB::Util.url_encode(path)}?action=#{action}")

        if recursive
          BrickFTP::Types::FolderContentsCount.new(total: res['data']['count'])
        else
          BrickFTP::Types::FolderContentsCount.new(res['data']['count'].symbolize_keys)
        end
      end
    end
  end
end
