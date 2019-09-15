# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::MoveFolder, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'move folder' do
        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/files/a%20b%2Fc')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: { 'move-destination': 'a b/d' }.to_json
          )
          .to_return(body: '[]')

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::MoveFolder::Params.new(path: 'a b/c', 'move-destination': 'a b/d')
        command = BrickFTP::RESTfulAPI::MoveFolder.new(rest)

        expect(command.call(params)).to be_truthy
      end
    end
  end
end
