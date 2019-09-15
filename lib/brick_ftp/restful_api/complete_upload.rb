# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # Completing an upload
    #
    # @see https://developers.files.com/#completing-an-upload Completing an upload
    #
    class CompleteUpload
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE    | DESCRIPTION
      # --------- | ------- | -----------
      # path      | string  | Required: Path
      # ref       | string  | Unique identifier to reference this file upload. This identifier is needed for subsequent requests to the REST API to complete the upload or request more upload URLs.
      Params = Struct.new(
        'CompleteUploadParams',
        :path,
        :ref,
        keyword_init: true
      )

      # After uploading the file to the file storage environment,
      # the REST API needs to be notified that the upload was completed.
      #
      # This is done by sending another POST request to `/files/PATH_AND_FILENAME.EXT` with
      # parameter `action` set to end and parameter `ref` set to the reference ID returned at the start of the upload.
      #
      # @param [BrickFTP::RESTfulAPI::CompleteUpload::Params] params parameters
      # @return [BrickFTP::Types::File]
      # @raise [BrickFTP::RESTfulAPI::Error] exception
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact.merge(action: 'end')
        path = params.delete(:path)
        res = client.post("/api/rest/v1/files/#{ERB::Util.url_encode(path)}", params)

        BrickFTP::Types::File.new(res.symbolize_keys)
      end
    end
  end
end
