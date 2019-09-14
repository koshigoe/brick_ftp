# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::CreateRemoteServer, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return created RemoteServer object' do
        created_group = BrickFTP::Types::RemoteServer.new(
          id: 1,
          aws_access_key: '[aws access key]',
          aws_secret_key: '[aws secret key]',
          hostname: 'remote-server.com',
          name: 'My Remote server',
          password: '[password]',
          port: 1,
          private_key: '[private key]',
          s3_bucket: 'my-bucket',
          s3_region: 'us-east-1',
          server_certificate: '[certificate]',
          server_type: 's3',
          ssl: 'always',
          username: 'user'
        )

        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/remote_servers.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: {
              aws_access_key: '[aws access key]',
              aws_secret_key: '[aws secret key]',
              hostname: 'remote-server.com',
              name: 'My Remote server',
              password: '[password]',
              port: 1,
              private_key: '[private key]',
              s3_bucket: 'my-bucket',
              s3_region: 'us-east-1',
              server_certificate: '[certificate]',
              server_type: 's3',
              ssl: 'always',
              username: 'user',
            }.to_json
          )
          .to_return(body: created_group.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::CreateRemoteServer::Params.new(
          aws_access_key: '[aws access key]',
          aws_secret_key: '[aws secret key]',
          hostname: 'remote-server.com',
          name: 'My Remote server',
          password: '[password]',
          port: 1,
          private_key: '[private key]',
          s3_bucket: 'my-bucket',
          s3_region: 'us-east-1',
          server_certificate: '[certificate]',
          server_type: 's3',
          ssl: 'always',
          username: 'user'
        )
        command = BrickFTP::RESTfulAPI::CreateRemoteServer.new(rest)

        expect(command.call(params)).to eq created_group
      end
    end
  end
end
