# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # Move or rename a file or folder
    #
    # @see https://developers.brickftp.com/#move-or-rename-a-file-or-folder Move or rename a file or folder
    #
    # ### Params
    #
    # PARAMETER        | TYPE   | DESCRIPTION
    # ---------------- | ------ | -----------
    # move-destination | string | Full path of the file or folder. Maximum of 550 characters.
    #
    class MoveFolder
      include Command
      using BrickFTP::CoreExt::Struct

      Params = Struct.new(
        'MoveFolderParams',
        :'move-destination',
        keyword_init: true
      )

      # Moves or renames a file or folder to the destination provided in
      # the `move-destination` parameter in the request body.
      # Note that a move/rename will fail if the destination already exists.
      #
      # @param [String] path Full path of the file or folder. Maximum of 550 characters.
      # @param [BrickFTP::RESTfulAPI::MoveFolder::Params] params parameters
      #
      def call(path, params)
        client.post("/api/rest/v1/files/#{ERB::Util.url_encode(path)}", params.to_h.compact)
        true
      end
    end
  end
end
