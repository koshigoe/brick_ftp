# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::UpdateRemoteServer, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return updated RemoteServer object' do
        updated_group = BrickFTP::Types::RemoteServer.new(
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

        stub_request(:put, 'https://subdomain.files.com/api/rest/v1/remote_servers/1.json')
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
          .to_return(body: updated_group.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::UpdateRemoteServer::Params.new(
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
          id: 1
        )
        command = BrickFTP::RESTfulAPI::UpdateRemoteServer.new(rest)

        expect(command.call(params)).to eq updated_group
      end
    end
  end
end
