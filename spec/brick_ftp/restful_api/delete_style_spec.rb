# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::DeleteStyle, type: :lib do
  describe '#call' do
    context 'given correct Style ID' do
      it 'return true' do
        stub_request(:delete, 'https://subdomain.files.com/api/rest/v1/styles/path')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: nil, status: 204)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::DeleteStyle.new(rest)

        expect(command.call(path: 'path')).to be_truthy
      end
    end
  end
end
