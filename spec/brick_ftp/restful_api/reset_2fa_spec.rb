# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::Reset2fa, type: :lib do
  describe '#call' do
    it 'return true' do
      stub_request(:post, 'https://subdomain.files.com/api/rest/v1/users/1/2fa/reset.json')
        .with(
          basic_auth: %w[api-key x],
          headers: {
            'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
          }
        )
        .to_return(body: nil, status: 204)

      rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
      command = BrickFTP::RESTfulAPI::Reset2fa.new(rest)

      expect(command.call(id: 1)).to be_truthy
    end
  end
end
