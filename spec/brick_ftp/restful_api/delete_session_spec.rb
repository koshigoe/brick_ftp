# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::DeleteSession, type: :lib do
  describe '#call' do
    it 'return true' do
      stub_request(:delete, 'https://subdomain.files.com/api/rest/v1/sessions.json')
        .with(
          basic_auth: %w[api-key x],
          headers: {
            'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
          }
        )
        .to_return(body: nil, status: 204)

      rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
      command = BrickFTP::RESTfulAPI::DeleteSession.new(rest)

      expect(command.call).to be_truthy
    end
  end
end
