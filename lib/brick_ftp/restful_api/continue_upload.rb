# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # Requesting additional upload URLs
    #
    # @see https://developers.files.com/#requesting-additional-upload-urls Requesting additional upload URLs
    #
    class ContinueUpload
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE    | DESCRIPTION
      # --------- | ------- | -----------
      # path      | string  | Required: Path
      # ref       | string  | Unique identifier to reference this file upload. This identifier is needed for subsequent requests to the REST API to complete the upload or request more upload URLs.
      # part      | integer | part number of multi part uploads.
      Params = Struct.new(
        'ContinueUploadParams',
        :path,
        :ref,
        :part,
        keyword_init: true
      )

      # Once an upload has been opened and before it is completed,
      # additional upload URLs can be requested from the REST API.
      #
      # Send a POST request to `/files/PATH_AND_FILENAME.EXT` with parameter `action` set to `put`, parameter `ref` set to
      # the reference ID returned at the start of the upload, and parameter `part` set to the part number the upload URL
      # should refer to. The part number can be the same as one previously used if a new URL is required, either
      # because the part is to be re-uploaded or because a prior upload attempt failed and the prior URL's signature
      # has expired.
      #
      # @param [BrickFTP::RESTfulAPI::ContinueUpload::Params] params parameters
      # @return [BrickFTP::Types::Upload]
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact.merge(action: 'put')
        path = params.delete(:path)
        res = client.post("/api/rest/v1/files/#{ERB::Util.url_encode(path)}", params)

        BrickFTP::Types::Upload.new(res.symbolize_keys)
      end
    end
  end
end
