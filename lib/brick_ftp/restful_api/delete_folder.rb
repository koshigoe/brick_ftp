# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # Delete a file or folder
    #
    # @see https://developers.files.com/#delete-a-file-or-folder Delete a file or folder
    #
    class DeleteFolder
      include Command

      # Deletes a file or folder.
      #
      # Note that this operation works for both files and folders, but normally it will only work on empty folders.
      # If you want to recursively delete a folder and all its contents, send the request with a `Depth` header
      # with the value set to `infinity`.
      #
      # @param [String] path Full path of the file or folder. Maximum of 550 characters.
      # @param [Boolean] recursive
      #
      def call(path, recursive: false)
        headers = {}
        headers = { 'Depth' => 'infinity' } if recursive

        client.delete("/api/rest/v1/files/#{ERB::Util.url_encode(path)}", headers)
        true
      end
    end
  end
end
