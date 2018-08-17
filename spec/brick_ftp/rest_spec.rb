# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::REST, type: :lib do
  describe '#get' do
    context 'HTTP 200 OK' do
      it 'return JSON parsed object' do
        stub_request(:get, 'https://subdomain.brickftp.com/path/to/resource.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: '{}')

        rest = BrickFTP::REST.new('subdomain', 'api-key')
        expect(rest.get('/path/to/resource.json')).to eq({})
      end
    end

    context 'HTTP 404 Not Found' do
      it 'raise exception' do
        stub_request(:get, 'https://subdomain.brickftp.com/path/to/resource.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: '404 Not Found', status: 404)

        rest = BrickFTP::REST.new('subdomain', 'api-key')
        expect { rest.get('/path/to/resource.json') }.to raise_error(BrickFTP::REST::Error)
      end
    end
  end
end