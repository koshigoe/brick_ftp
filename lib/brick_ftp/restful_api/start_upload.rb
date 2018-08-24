# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    class StartUpload
      include Command

      # The first request to upload a new file is a POST request to /files/PATH_AND_FILENAME.EXT
      # with an action parameter with the value of put.
      #
      # @param [String] path Full path of the file or folder. Maximum of 550 characters.
      # @return [BrickFTP::Types::Upload] Upload object
      #
      def call(path)
        res = client.post("/api/rest/v1/files/#{ERB::Util.url_encode(path)}", action: 'put')

        BrickFTP::Types::Upload.new(res.symbolize_keys)
      end
    end
  end
end
