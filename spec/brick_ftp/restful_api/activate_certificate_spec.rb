# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::ActivateCertificate, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return empty body' do
        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/certificates/1234/activate.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: { replace_cert: '' }.to_json
          )
          .to_return(body: nil, status: 204)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::ActivateCertificate::Params.new(id: 1234, replace_cert: '')
        command = BrickFTP::RESTfulAPI::ActivateCertificate.new(rest)

        expect(command.call(params)).to be_truthy
      end
    end
  end
end
