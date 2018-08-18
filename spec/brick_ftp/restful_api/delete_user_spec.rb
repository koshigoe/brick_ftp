# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::DeleteUser, type: :lib do
  describe '#call' do
    context 'given correct User ID' do
      it 'return true' do
        stub_request(:delete, 'https://subdomain.brickftp.com/api/rest/v1/users/1234.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: '[]')

        rest = BrickFTP::REST.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::DeleteUser.new(rest)

        expect(command.call(1234)).to be_truthy
      end
    end
  end
end
