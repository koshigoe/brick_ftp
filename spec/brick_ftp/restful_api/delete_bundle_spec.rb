# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::DeleteBundle, type: :lib do
  describe '#call' do
    context 'given correct Bundle ID' do
      it 'return true' do
        stub_request(:delete, 'https://subdomain.files.com/api/rest/v1/bundles/1234.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: nil, status: 204)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::DeleteBundle.new(rest)

        expect(command.call(1234)).to be_truthy
      end
    end
  end
end
