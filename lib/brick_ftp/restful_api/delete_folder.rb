# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # Delete file/folder
    #
    # @see https://developers.files.com/#delete-file-folder Delete file/folder
    #
    class DeleteFolder
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE    | DESCRIPTION
      # --------- | ------- | -----------
      # path      | string  | Required: Path
      Params = Struct.new(
        'DeleteFolderParams',
        :path,
        :recursive,
        keyword_init: true
      )

      # Delete file/folder
      #
      # @param [BrickFTP::RESTfulAPI::DeleteFolder::Params] params parameters
      #
      def call(params = {})
        headers = {}
        headers = { 'Depth' => 'infinity' } if params[:recursive]

        client.delete("/api/rest/v1/files/#{ERB::Util.url_encode(params[:path])}", nil, headers)
        true
      end
    end
  end
end
