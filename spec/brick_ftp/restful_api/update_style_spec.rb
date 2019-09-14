# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::UpdateStyle, type: :lib do
  describe '#call' do
    context 'given correct parameters' do
      it 'return updated Style object' do
        updated_style = BrickFTP::Types::Style.new(
          logo: '',
          path: '',
          thumbnail: ''
        )

        stub_request(:put, 'https://subdomain.files.com/api/rest/v1/styles/path')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: {
              file: 'file',
            }.to_json
          )
          .to_return(body: updated_style.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        params = BrickFTP::RESTfulAPI::UpdateStyle::Params.new(
          path: 'path',
          file: 'file'
        )
        command = BrickFTP::RESTfulAPI::UpdateStyle.new(rest)

        expect(command.call(params)).to eq updated_style
      end
    end
  end
end
