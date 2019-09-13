# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::Client, type: :lib do
  describe '#get' do
    context 'HTTP 200 OK' do
      it 'return JSON parsed object' do
        stub_request(:get, 'https://subdomain.files.com/path/to/resource.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
              'Depth' => 'infinity',
            }
          )
          .to_return(body: '{}')

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        expect(rest.get('/path/to/resource.json', 'Depth' => 'infinity')).to eq({})
      end
    end

    context 'HTTP 404 Not Found' do
      it 'raise exception' do
        stub_request(:get, 'https://subdomain.files.com/path/to/resource.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
              'Depth' => 'infinity',
            }
          )
          .to_return(body: 'Not Found', status: 404)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        expect { rest.get('/path/to/resource.json', 'Depth' => 'infinity') }
          .to raise_error(BrickFTP::RESTfulAPI::Client::Error) do |e|
          expect(e.error['http-code']).to eq '404'
          expect(e.error['error']).to eq 'Not Found'
        end
      end
    end
  end

  describe '#post' do
    context 'HTTP 200 OK' do
      it 'return JSON parsed object' do
        stub_request(:post, 'https://subdomain.files.com/path/to/resource.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
              'Content-Type' => 'application/json',
              'Depth' => 'infinity',
            },
            body: '{}'
          )
          .to_return(body: '{}')

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        expect(rest.post('/path/to/resource.json', {}, 'Depth' => 'infinity')).to eq({})
      end
    end

    context 'HTTP 400 Bad Request' do
      it 'raise exception' do
        stub_request(:post, 'https://subdomain.files.com/path/to/resource.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
              'Depth' => 'infinity',
            },
            body: '{}'
          )
          .to_return(body: '{"error":"invalid","http-code":"400"}', status: 400)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        expect { rest.post('/path/to/resource.json', {}, 'Depth' => 'infinity') }
          .to raise_error(BrickFTP::RESTfulAPI::Client::Error) do |e|
          expect(e.error['http-code']).to eq '400'
          expect(e.error['error']).to eq 'invalid'
        end
      end
    end
  end

  describe '#put' do
    context 'HTTP 200 OK' do
      it 'return JSON parsed object' do
        stub_request(:put, 'https://subdomain.files.com/path/to/resource.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
              'Content-Type' => 'application/json',
              'Depth' => 'infinity',
            },
            body: '{}'
          )
          .to_return(body: '{}')

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        expect(rest.put('/path/to/resource.json', {}, 'Depth' => 'infinity')).to eq({})
      end
    end

    context 'HTTP 400 Bad Request' do
      it 'raise exception' do
        stub_request(:put, 'https://subdomain.files.com/path/to/resource.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
              'Depth' => 'infinity',
            },
            body: '{}'
          )
          .to_return(body: '{"error":"invalid","http-code":"400"}', status: 400)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        expect { rest.put('/path/to/resource.json', {}, 'Depth' => 'infinity') }
          .to raise_error(BrickFTP::RESTfulAPI::Client::Error) do |e|
          expect(e.error['http-code']).to eq '400'
          expect(e.error['error']).to eq 'invalid'
        end
      end
    end
  end

  describe '#patch' do
    context 'HTTP 200 OK' do
      it 'return JSON parsed object' do
        stub_request(:patch, 'https://subdomain.files.com/path/to/resource.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
              'Content-Type' => 'application/json',
              'Depth' => 'infinity',
            },
            body: '{}'
          )
          .to_return(body: '{}')

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        expect(rest.patch('/path/to/resource.json', {}, 'Depth' => 'infinity')).to eq({})
      end
    end

    context 'HTTP 400 Bad Request' do
      it 'raise exception' do
        stub_request(:patch, 'https://subdomain.files.com/path/to/resource.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
              'Depth' => 'infinity',
            },
            body: '{}'
          )
          .to_return(body: '{"error":"invalid","http-code":"400"}', status: 400)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        expect { rest.patch('/path/to/resource.json', {}, 'Depth' => 'infinity') }
          .to raise_error(BrickFTP::RESTfulAPI::Client::Error) do |e|
          expect(e.error['http-code']).to eq '400'
          expect(e.error['error']).to eq 'invalid'
        end
      end
    end
  end

  describe '#delete' do
    context 'HTTP 200 OK' do
      it 'return JSON parsed object' do
        stub_request(:delete, 'https://subdomain.files.com/path/to/resource.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
              'Content-Type' => 'application/json',
              'Depth' => 'infinity',
            },
            body: '{}'
          )
          .to_return(body: '{}')

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        expect(rest.delete('/path/to/resource.json', {}, 'Depth' => 'infinity')).to eq({})
      end
    end

    context 'HTTP 400 Bad Request' do
      it 'raise exception' do
        stub_request(:delete, 'https://subdomain.files.com/path/to/resource.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
              'Depth' => 'infinity',
            },
            body: '{}'
          )
          .to_return(body: '{"error":"invalid","http-code":"400"}', status: 400)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        expect { rest.delete('/path/to/resource.json', {}, 'Depth' => 'infinity') }
          .to raise_error(BrickFTP::RESTfulAPI::Client::Error) do |e|
          expect(e.error['http-code']).to eq '400'
          expect(e.error['error']).to eq 'invalid'
        end
      end
    end
  end

  describe '#upload_file' do
    context '200 OK' do
      it 'upload file' do
        stub_request(:post, 'https://www.example.com/')
          .with(body: 'TEST')
          .to_return(body: '', status: 200)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        url = 'https://www.example.com/'
        io = StringIO.new('TEST')

        expect(rest.upload_file('POST', url, io)).to eq 4
      end
    end

    context 'Invalida HTTP method' do
      it 'raise ArgumentError' do
        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        url = 'http://www.example.com/'
        io = StringIO.new

        expect { rest.upload_file('GET', url, io) }.to raise_error(ArgumentError, 'Unsupported HTTP method `GET`')
      end
    end

    context 'HTTP Error' do
      it 'raise exception' do
        stub_request(:post, 'http://www.example.com/')
          .with(body: 'TEST')
          .to_return(body: 'Bad Request', status: 400)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        url = 'http://www.example.com/'
        io = StringIO.new('TEST')

        expect { rest.upload_file('POST', url, io) }
          .to raise_error(BrickFTP::RESTfulAPI::Client::Error) do |e|
          expect(e.error['http-code']).to eq '400'
          expect(e.error['error']).to eq 'Bad Request'
        end
      end
    end
  end
end
