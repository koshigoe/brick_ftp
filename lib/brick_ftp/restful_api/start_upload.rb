# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # Starting a new upload
    #
    # @see https://developers.files.com/#starting-a-new-upload Starting a new upload
    #
    class StartUpload
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE    | DESCRIPTION
      # --------- | ------- | -----------
      # path      | string  | Required: Path
      Params = Struct.new(
        'StartUploadParams',
        :path,
        keyword_init: true
      )

      # The first request to upload a new file is a POST request to /files/PATH_AND_FILENAME.EXT
      # with an action parameter with the value of put.
      #
      # @param [BrickFTP::RESTfulAPI::StartUpload::Params] params parameters
      # @return [BrickFTP::Types::Upload]
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        path = params.delete(:path)
        res = client.post("/api/rest/v1/files/#{ERB::Util.url_encode(path)}", action: 'put')

        BrickFTP::Types::Upload.new(res.symbolize_keys)
      end
    end
  end
end
