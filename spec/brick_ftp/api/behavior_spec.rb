require 'spec_helper'

RSpec.describe BrickFTP::API::Behavior, type: :lib do
  before { BrickFTP.config.api_key = 'xxxxxxxx' }

  describe '.all' do
    subject { described_class.all }

    let(:behaviors) do
      [
        {
          'id' => 38,
          'path' => 'Finance',
          'behavior' => 'webhook',
          'value' => [
            'https://a.mywebhookhandler.com'
          ]
        },
        {
          'id' => 39,
          'path' => 'cloud/images',
          'behavior' => 'webhook',
          'value' => [
            'https://b.mywebhookhandler.com',
            'https://c.mywebhookhandler.com'
          ]
        }
      ]
    end

    before do
      stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/behaviors.json')
        .with(basic_auth: ['xxxxxxxx', 'x'])
        .to_return(status: 200, body: behaviors.to_json)
    end

    it 'return instance of BrickFTP::API::Behavior' do
      is_expected.to all(be_an_instance_of(BrickFTP::API::Behavior))
    end

    it 'set attributes' do
      downloads = subject
      expect(downloads.first.id).to eq 38
      expect(downloads.first.path).to eq 'Finance'
      expect(downloads.first.behavior).to eq 'webhook'
      expect(downloads.first.value).to eq %w[https://a.mywebhookhandler.com]
    end
  end

  describe '.find' do
    subject { described_class.find(38) }

    let(:behavior) do
      {
        'id' => 38,
        'path' => 'Finance',
        'behavior' => 'webhook',
        'value' => [
          'https://a.mywebhookhandler.com'
        ]
      }
    end

    context 'exists' do
      before do
        stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/behaviors/38.json')
          .with(basic_auth: ['xxxxxxxx', 'x'])
          .to_return(body: behavior.to_json)
      end

      it 'return instance of BrickFTP::API::Behavior' do
        is_expected.to be_an_instance_of BrickFTP::API::Behavior
      end

      it 'set attributes' do
        behavior = subject
        expect(behavior.id).to eq 38
        expect(behavior.path).to eq 'Finance'
        expect(behavior.behavior).to eq 'webhook'
        expect(behavior.value).to eq %w[https://a.mywebhookhandler.com]
      end
    end

    context 'not exists' do
      before do
        stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/behaviors/38.json')
          .with(basic_auth: ['xxxxxxxx', 'x'])
          .to_return(body: '[]')
      end

      it 'return nil' do
        is_expected.to be_nil
      end
    end
  end

  describe '.create' do
    subject { described_class.create(params) }

    context 'success' do
      let(:params) do
        {
          'path' => 'cloud/images',
          'behavior' => 'webhook',
          'value' => [
            'https://d.mywebhookhandler.com'
          ]
        }
      end

      let(:behavior) do
        {
          'id' => 39,
          'path' => 'cloud/images',
          'behavior' => 'webhook',
          'value' => [
            'https://d.mywebhookhandler.com'
          ]
        }
      end

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/behaviors.json')
          .with(body: params.to_json, basic_auth: ['xxxxxxxx', 'x'])
          .to_return(status: 201, body: behavior.to_json)
      end

      it 'return instance of BrickFTP::API::Behavior' do
        is_expected.to be_an_instance_of BrickFTP::API::Behavior
      end

      it 'set attributes' do
        behavior = subject
        expect(behavior.id).to eq 39
        expect(behavior.path).to eq 'cloud/images'
        expect(behavior.behavior).to eq 'webhook'
        expect(behavior.value).to eq %w[https://d.mywebhookhandler.com]
      end
    end

    context 'failure' do
      let(:params) { {} }

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/behaviors.json')
          .with(basic_auth: ['xxxxxxxx', 'x'])
          .to_return(status: 500, body: { 'error' => 'xxxxxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end
  end

  describe '#update' do
    subject { behavior.update(params) }

    let(:behavior) { described_class.new(id: 39, value: []) }
    let(:params) { { value: %w[https://e.mywebhookhandler.com] } }

    context 'success' do
      let(:updated_behavior) do
        {
          'id' => 39,
          'path' => 'cloud/images',
          'behavior' => 'webhook',
          'value' => [
            'https://e.mywebhookhandler.com'
          ]
        }
      end

      before do
        stub_request(:put, 'https://koshigoe.brickftp.com/api/rest/v1/behaviors/39.json')
          .with(body: params.to_json, basic_auth: ['xxxxxxxx', 'x'])
          .to_return(body: updated_behavior.to_json)
      end

      it 'return self' do
        is_expected.to eq behavior
      end

      it 'update attributes' do
        expect { subject }.to change { behavior.value[0] }.to('https://e.mywebhookhandler.com')
      end
    end

    context 'failure' do
      before do
        stub_request(:put, 'https://koshigoe.brickftp.com/api/rest/v1/behaviors/39.json')
          .with(basic_auth: ['xxxxxxxx', 'x'])
          .to_return(status: 500, body: { 'error' => 'xxxxxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end
  end

  describe '#destroy' do
    subject { behavior.destroy }

    let(:behavior) { described_class.new(id: 39) }

    before do
      stub_request(:delete, 'https://koshigoe.brickftp.com/api/rest/v1/behaviors/39.json')
        .with(basic_auth: ['xxxxxxxx', 'x'])
        .to_return(body: '[]')
    end

    it 'return true' do
      is_expected.to eq true
    end
  end
end
