# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::CreateFolder, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return created Folder object' do
        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/folders/a%20b%2Fc')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: nil, status: 204)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::CreateFolder.new(rest)

        expect(command.call(path: 'a b/c')).to be_truthy
      end
    end
  end
end
