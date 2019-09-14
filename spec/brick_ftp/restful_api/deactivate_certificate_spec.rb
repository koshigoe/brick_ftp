# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::DeactivateCertificate, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return empty body' do
        stub_request(:post, 'https://subdomain.files.com/api/rest/v1/certificates/1234/deactivate.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: nil, status: 204)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::DeactivateCertificate.new(rest)

        expect(command.call(id: 1234)).to be_truthy
      end
    end
  end
end
