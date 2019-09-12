# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::GetBundle, type: :lib do
  describe '#call' do
    context 'given correct Bundle ID' do
      it 'return Bundle object' do
        expected_bundle = BrickFTP::Types::Bundle.new(
          code: 'abc123',
          created_at: '2000-01-01 01:00:00 UTC',
          description: 'The public description of the bundle.',
          expires_at: '2000-01-01 01:00:00 UTC',
          paths: [],
          id: 1,
          note: 'The internal note on the bundle.',
          password_protected: true,
          url: 'https://subdomain.files.com/f/12345678',
          user_id: 1,
          username: 'user'
        )

        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/bundles/1234.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: expected_bundle.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::GetBundle.new(rest)

        expect(command.call(1234)).to eq expected_bundle
      end
    end

    context 'Bundle not found' do
      it 'return nil' do
        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/bundles/1234.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: '[]')

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::GetBundle.new(rest)

        expect(command.call(1234)).to be_nil
      end
    end
  end
end
