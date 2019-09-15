# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # Move or rename a file or folder
    #
    # @see https://developers.files.com/#move-or-rename-a-file-or-folder Move or rename a file or folder
    #
    class MoveFolder
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER        | TYPE   | DESCRIPTION
      # ---------------- | ------ | -----------
      # path             | string | Path
      # move-destination | string | Full path of the file or folder. Maximum of 550 characters.
      Params = Struct.new(
        'MoveFolderParams',
        :path,
        :'move-destination',
        keyword_init: true
      )

      # Moves or renames a file or folder to the destination provided in
      # the `move-destination` parameter in the request body.
      # Note that a move/rename will fail if the destination already exists.
      #
      # @param [BrickFTP::RESTfulAPI::MoveFolder::Params] params parameters
      #
      def call(params)
        params = Params.new(params.to_h).to_h.compact
        path = params.delete(:path)
        client.post("/api/rest/v1/files/#{ERB::Util.url_encode(path)}", params)
        true
      end
    end
  end
end
