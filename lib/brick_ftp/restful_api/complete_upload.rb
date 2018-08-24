# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    class CompleteUpload
      include Command

      # rubocop:disable Metrics/LineLength, Layout/CommentIndentation
      Params = Struct.new(
        'CompleteUploadParams',
        :ref,  # string  | Unique identifier to reference this file upload. This identifier is needed for
               #         | subsequent requests to the REST API to complete the upload or request more upload URLs.
        keyword_init: true
      )
      # rubocop:enable Metrics/LineLength, Layout/CommentIndentation

      # After uploading the file to the file storage environment,
      # the REST API needs to be notified that the upload was completed.
      #
      # This is done by sending another POST request to `/files/PATH_AND_FILENAME.EXT` with
      # parameter `action` set to end and parameter `ref` set to the reference ID returned at the start of the upload.
      #
      # @param [String] path Full path of the file or folder. Maximum of 550 characters.
      # @param [BrickFTP::RESTfulAPI::CompleteUpload::Params] params parameters
      # @return [BrickFTP::Types::File] File object
      #
      def call(path, params)
        res = client.post("/api/rest/v1/files/#{ERB::Util.url_encode(path)}", params.to_h.compact.merge(action: 'end'))

        BrickFTP::Types::File.new(res.symbolize_keys)
      end
    end
  end
end
