# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create remote server
    #
    # @see https://developers.files.com/#create-remote-server Create remote server
    #
    # ### Params
    #
    # PARAMETER          | TYPE    | DESCRIPTION
    # ------------------ | ------- | -----------
    # aws_access_key     | string  | AWS Access Key.
    # aws_secret_key     | string  | AWS secret key.
    # hostname           | string  | Hostname.
    # name               | string  | Internal reference name for server.
    # password           | string  | Password if needed.
    # port               | string  | Port.
    # private_key        | string  | Private key if needed.
    # s3_bucket          | string  | S3 bucket name.
    # s3_region          | string  | S3 region.
    # server_certificate | string  | Certificate for this server.
    # server_type        | string  | Type of server. Can be ftp, sftp, or s3.
    # ssl                | string  | SSL requirements. Can be if_available, require, require_implicit, never.
    # username           | string  | Server username if needed.
    #
    class CreateRemoteServer
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'CreateRemoteServerParams',
        :aws_access_key,
        :aws_secret_key,
        :hostname,
        :name,
        :password,
        :port,
        :private_key,
        :s3_bucket,
        :s3_region,
        :server_certificate,
        :server_type,
        :ssl,
        :username,
        keyword_init: true
      )

      # Create remote server
      #
      # @param [BrickFTP::RESTfulAPI::CreateRemoteServer::Params] params parameters
      # @return [BrickFTP::Types::RemoteServer]
      #
      def call(params)
        res = client.post('/api/rest/v1/remote_servers.json', Params.new(params.to_h).to_h.compact)

        BrickFTP::Types::RemoteServer.new(res.symbolize_keys)
      end
    end
  end
end
