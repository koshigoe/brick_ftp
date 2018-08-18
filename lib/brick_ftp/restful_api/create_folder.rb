# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    class CreateFolder
      include Command

      # Creates a folder.
      #
      # @param [String] path
      # @return [BrickFTP::Types::Folder] Folders
      #
      def call(path)
        client.post("/api/rest/v1/folders/#{ERB::Util.url_encode(path)}")
        true
      end
    end
  end
end
