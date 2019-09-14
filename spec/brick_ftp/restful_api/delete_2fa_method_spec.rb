# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::Delete2faMethod, type: :lib do
  describe '#call' do
    it 'return true' do
      stub_request(:delete, 'https://subdomain.files.com/api/rest/v1/2fa/1.json')
        .with(
          basic_auth: %w[api-key x],
          headers: {
            'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
          }
        )
        .to_return(body: nil, status: 204)

      rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
      command = BrickFTP::RESTfulAPI::Delete2faMethod.new(rest)

      expect(command.call(id: 1)).to be_truthy
    end
  end
end
