# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ListRemoteServers, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return Array of RemoteServer object' do
        expected_remote_server = BrickFTP::Types::RemoteServer.new(
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

        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/remote_servers.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_remote_server.to_h].to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::ListRemoteServers.new(rest)

        expect(command.call).to eq([expected_remote_server])
      end
    end
  end
end
