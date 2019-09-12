# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # The RemoteServer object
    #
    # @see https://developers.files.com/#the-remoteserver-object The RemoteServer object
    #
    # ATTRIBUTE          | TYPE    | DESCRIPTION
    # ------------------ | ------- | -----------
    # id                 | integer | Remote server ID
    # aws_access_key     | string  | AWS Access Key, if connecting to S3
    # aws_secret_key     | string  | AWS Secret Key, if connecting to S3
    # hostname           | string  | Hostname or IP address
    # name               | string  | Internal name for your reference
    # password           | string  | Remote server password. For FTP or SFTP without private key authentication.
    # port               | integer | Port for remote server. Not needed for S3.
    # private_key        | string  | Private key. Needed for SFTP if authenticating via private key.
    # s3_bucket          | string  | S3 bucket name
    # s3_region          | string  | S3 region
    # server_certificate | string  | Remote server certificate
    # server_type        | string  | Remote server type.
    # ssl                | string  | Should we require SSL?
    # username           | string  | Remote server username. Not needed for S3 buckets.
    #
    RemoteServer = Struct.new(
      'RemoteServer',
      :id,
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
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
