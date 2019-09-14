# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # List remote servers
    #
    # @see https://developers.files.com/#list-remote-servers List remote servers
    #
    class ListRemoteServers
      include Command
      using BrickFTP::CoreExt::Hash

      # List remote servers
      #
      # @return [Array<BrickFTP::Types::RemoteServer>]
      #
      def call
        res = client.get('/api/rest/v1/remote_servers.json')

        res.map { |i| BrickFTP::Types::RemoteServer.new(i.symbolize_keys) }
      end
    end
  end
end
