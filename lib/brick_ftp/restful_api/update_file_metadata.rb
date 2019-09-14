# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # Update file/folder metadata
    #
    # @see https://developers.files.com/#update-file-folder-metadata Update file/folder metadata
    #
    # ### Params
    #
    # PARAMETER      | TYPE    | DESCRIPTION
    # -------------- | ------- | -----------
    # path           | string  | Required: Path
    # provided_mtime | string  | Modified time of file.
    # priority_color | string  | Priority/Bookmark color of file.
    #
    class UpdateFileMetadata
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'UpdateFileMetadataParams',
        :path,
        :provided_mtime,
        :priority_color,
        keyword_init: true
      )

      # Update file/folder metadata
      #
      # @param [BrickFTP::RESTfulAPI::UpdateFileMetadata::Params] params parameters
      # @return [BrickFTP::Types::File]
      #
      def call(params)
        params = params.to_h.compact
        path = params.delete(:path)
        res = client.patch("/api/rest/v1/files/#{ERB::Util.url_encode(path)}", params)

        BrickFTP::Types::File.new(res.symbolize_keys)
      end
    end
  end
end
