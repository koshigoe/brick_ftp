# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Update remote server
    #
    # @see https://developers.files.com/#update-remote-server Update remote server
    #
    class UpdateRemoteServer
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

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
      # id                 | integer | Required
      Params = Struct.new(
        'UpdateRemoteServerParams',
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
        :id,
        keyword_init: true
      )

      # Update remote server
      #
      # @param [BrickFTP::RESTfulAPI::UpdateRemoteServer::Params] params parameters
      # @return [BrickFTP::Types::RemoteServer]
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        res = client.put("/api/rest/v1/remote_servers/#{params.delete(:id)}.json", params)

        BrickFTP::Types::RemoteServer.new(res.symbolize_keys)
      end
    end
  end
end
