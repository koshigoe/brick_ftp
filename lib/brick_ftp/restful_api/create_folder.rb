# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # Create folder
    #
    # @see https://developers.files.com/#create-folder Create folder
    #
    class CreateFolder
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE    | DESCRIPTION
      # --------- | ------- | -----------
      # path      | string  | Required: Path
      Params = Struct.new(
        'CreateFolderParams',
        :path,
        keyword_init: true
      )

      # Create folder
      #
      # @param [BrickFTP::RESTfulAPI::CreateFolder::Params] params parameters
      #
      def call(params = {})
        client.post("/api/rest/v1/folders/#{ERB::Util.url_encode(params[:path])}")
        true
      end
    end
  end
end
