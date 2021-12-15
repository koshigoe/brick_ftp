# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::Client, type: :lib do
  describe '#initialize (deprecated)' do
    around do |example|
      subdomain = ENV['BRICK_FTP_SUBDOMAIN']
      api_key = ENV['BRICK_FTP_API_KEY']
      ENV.update('BRICK_FTP_SUBDOMAIN' => 'env-subdomain', 'BRICK_FTP_API_KEY' => 'env-api_key')

      example.run

      ENV.update('BRICK_FTP_SUBDOMAIN' => subdomain, 'BRICK_FTP_API_KEY' => api_key)
    end

    context 'omit argument' do
      it 'use environment variables' do
        client = BrickFTP::Client.new

        aggregate_failures do
          expect(client.subdomain).to eq 'env-subdomain'
          expect(client.api_key).to eq 'env-api_key'
        end
      end
    end

    context 'pass arguments' do
      it 'use arguments' do
        client = BrickFTP::Client.new(subdomain: 'subdomain', api_key: 'api_key')

        aggregate_failures do
          expect(client.subdomain).to eq 'subdomain'
          expect(client.api_key).to eq 'api_key'
        end
      end
    end
  end

  describe '#initialize' do
    around do |example|
      base_url = ENV['BRICK_FTP_BASE_URL']
      api_key = ENV['BRICK_FTP_API_KEY']
      ENV.update('BRICK_FTP_BASE_URL' => 'http://127.0.0.1:40410/', 'BRICK_FTP_API_KEY' => 'env-api_key')

      example.run

      ENV.update('BRICK_FTP_BASE_URL' => base_url, 'BRICK_FTP_API_KEY' => api_key)
    end

    context 'omit argument' do
      it 'use environment variables' do
        client = BrickFTP::Client.new

        aggregate_failures do
          expect(client.base_url).to eq 'http://127.0.0.1:40410/'
          expect(client.api_key).to eq 'env-api_key'
        end
      end
    end

    context 'pass arguments' do
      it 'use arguments' do
        client = BrickFTP::Client.new(base_url: 'http://127.0.0.1:40410/', api_key: 'api_key')

        aggregate_failures do
          expect(client.base_url).to eq 'http://127.0.0.1:40410/'
          expect(client.api_key).to eq 'api_key'
        end
      end
    end
  end

  describe 'delegate' do
    context 'command found' do
      it 'dipatch command' do
        client = BrickFTP::Client.new(subdomain: 'subdomain', api_key: 'api-key')
        id = double

        expect(BrickFTP::RESTfulAPI::GetUser).to receive_message_chain(:new, :call).with(client.api_client).with(id)
        expect(client).to be_respond_to(:get_user)
        client.get_user(id)
      end

      context 'API has keyword argument' do
        it 'dispatch command' do
          stub_request(:get, 'https://subdomain.files.com/api/rest/v1/folders/path?action=count')
            .with(
              basic_auth: %w[api-key x],
              headers: {
                'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
              }
            )
            .to_return(body: { data: { count: 3 } }.to_json)

          client = BrickFTP::Client.new(base_url: 'https://subdomain.files.com/', api_key: 'api-key')

          res = client.count_folder_contents('path', recursive: true)
          expect(res).to eq BrickFTP::Types::FolderContentsCount.new(total: 3)
        end
      end
    end

    context 'command not found' do
      it 'raise NoMethodError' do
        client = BrickFTP::Client.new(subdomain: 'subdomain', api_key: 'api-key')

        expect(client).not_to be_respond_to(:command_not_found)
        expect { client.command_not_found }.to raise_error(NoMethodError)
      end
    end
  end
end
