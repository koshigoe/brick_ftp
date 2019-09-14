# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete remote server
    #
    # @see https://developers.files.com/#delete-remote-server Delete remote server
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Required: Remote Server ID.
    #
    class DeleteRemoteServer
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'DeleteRemoteServerParams',
        :id,
        keyword_init: true
      )

      # Delete remote server
      #
      # @param [BrickFTP::RESTfulAPI::DeleteRemoteServer::Params] params parameters
      #
      def call(params)
        params = Params.new(params.to_h).to_h.compact
        client.delete("/api/rest/v1/remote_servers/#{params[:id]}.json")
        true
      end
    end
  end
end
