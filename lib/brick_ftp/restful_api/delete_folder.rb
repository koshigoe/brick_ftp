# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # Delete a file or folder
    #
    # @see https://developers.files.com/#delete-file-folder Delete file/folder
    #
    class DeleteFolder
      include Command

      # Deletes a file or folder.
      #
      # > If true, will recursively delete folers. Otherwise, will error on non-empty folders.
      #
      # @param [String] path Full path of the file or folder. Maximum of 550 characters.
      # @param [Boolean] recursive
      #
      def call(path, recursive: false)
        url = "/api/rest/v1/files/#{ERB::Util.url_encode(path)}"
        url += '?recursive=true' if recursive

        client.delete(url)
        true
      end
    end
  end
end
