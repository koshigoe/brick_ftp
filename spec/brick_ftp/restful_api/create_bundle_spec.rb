# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::CreateBundle, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return created Bundle object' do
        created_bundle = BrickFTP::Types::Bundle.new(
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

        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/bundles.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: {
              paths: ['file.txt'],
              password: 'Password',
              expires_at: '2000-01-01 01:00:00 UTC',
              description: 'Public description',
              note: 'Internal Note',
            }.to_json
          )
          .to_return(body: created_bundle.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::CreateBundle::Params.new(
          paths: ['file.txt'],
          password: 'Password',
          expires_at: '2000-01-01 01:00:00 UTC',
          description: 'Public description',
          note: 'Internal Note'
        )
        command = BrickFTP::RESTfulAPI::CreateBundle.new(rest)

        expect(command.call(params)).to eq created_bundle
      end
    end
  end
end
