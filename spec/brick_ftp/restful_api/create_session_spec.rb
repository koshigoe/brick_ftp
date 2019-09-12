# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::CreateSession, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return created Session object' do
        created_session = BrickFTP::Types::Session.new(
          id: 1,
          language: 'en',
          login_token: '@tok-randomcode',
          login_token_domain: 'https://mysite.files.com',
          max_dir_listing_size: 1,
          multiple_regions: true,
          root_path: "",
          site_id: 1,
          ssl_required: true,
          tls_disabled: true,
          two_factor_setup_needed: true,
          allowed_2fa_method_sms: true,
          allowed_2fa_method_totp: true,
          allowed_2fa_method_u2f: true,
          allowed_2fa_method_yubi: true,
          use_provided_modified_at: true,
          windows_mode_ftp: true,
        )

        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/sessions.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: {
              username: 'username',
              password: 'password',
              otp: '123456',
            }.to_json
          )
          .to_return(body: created_session.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::CreateSession::Params.new(
          username: 'username',
          password: 'password',
          otp: '123456',
        )
        command = BrickFTP::RESTfulAPI::CreateSession.new(rest)

        expect(command.call(params)).to eq created_session
      end
    end
  end
end
