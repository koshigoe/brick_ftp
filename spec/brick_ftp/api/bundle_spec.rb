require 'spec_helper'

RSpec.describe BrickFTP::API::Bundle, type: :lib do
  before { BrickFTP.config.api_key = 'xxxxxxxx' }

  describe '.all' do
    subject { described_class.all }

    let(:bundles) do
      [
        {
          "id" => 212228,
          "code" => "4d3d3d3d3",
          "url" => "https://site.brickftp.com/f/4d3d3d3d3",
          "user_id" => 12345,
          "created_at" => "2015-10-14T12:52:25-04:00",
          "paths" => [
            "accounts.xls"
          ]
        },
        {
          "id" => 212468,
          "code" => "012345678",
          "url" => "https://site.brickftp.com/f/012345678",
          "user_id" => 12345,
          "created_at" => "2015-10-14T19:07:45-04:00",
          "paths" => [
            "cloud/images",
            "cloud/documents",
            "backup.zip"
          ]
        }
      ]
    end

    before do
      stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/bundles.json')
        .with(basic_auth: ['xxxxxxxx', 'x'])
        .to_return(body: bundles.to_json)
    end

    it 'return Array of BrickFTP::API::Bundle' do
      is_expected.to all(be_an_instance_of(BrickFTP::API::Bundle))
    end

    it 'set attributes' do
      groups = subject
      expect(groups.first.id).to eq 212228
      expect(groups.first.code).to eq "4d3d3d3d3"
      expect(groups.first.url).to eq "https://site.brickftp.com/f/4d3d3d3d3"
      expect(groups.first.user_id).to eq 12345
      expect(groups.first.created_at).to eq "2015-10-14T12:52:25-04:00"
      expect(groups.first.paths).to eq ["accounts.xls"]
    end
  end

  describe '.find' do
    subject { described_class.find(212228) }

    let(:bundle) do
      {
        "id" =>  212228,
        "code" =>  "4d3d3d3d3",
        "url" => "https://site.brickftp.com/f/4d3d3d3d3",
        "user_id" =>  12345,
        "created_at" =>  "2015-10-14T12:52:25-04:00",
        "paths" =>  [
          "accounts.xls"
        ]
      }
    end

    context 'exists' do
      before do
        stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/bundles/212228.json')
          .with(basic_auth: ['xxxxxxxx', 'x'])
          .to_return(body: bundle.to_json)
      end

      it 'return instance of BrickFTP::API::Bundle' do
        is_expected.to be_an_instance_of BrickFTP::API::Bundle
      end

      it 'set attributes' do
        group = subject
        expect(group.id).to eq 212228
        expect(group.code).to eq "4d3d3d3d3"
        expect(group.url).to eq "https://site.brickftp.com/f/4d3d3d3d3"
        expect(group.user_id).to eq 12345
        expect(group.created_at).to eq "2015-10-14T12:52:25-04:00"
        expect(group.paths).to eq ["accounts.xls"]
      end
    end

    context 'not exists' do
      before do
        stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/bundles/212228.json')
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
          "paths" =>  [
            "cloud/images",
            "backup.zip"
          ]
        }
      end

      let(:bundle) do
        {
          "id" =>  221260,
          "code" =>  "a0b1c2d3e",
          "url" => "https://site.brickftp.com/f/a0b1c2d3e",
          "user_id" =>  nil,
          "created_at" =>  "2015-11-12T15:49:30-05:00",
          "paths" =>  [
            "cloud/images",
            "backup.zip"
          ]
        }
      end

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/bundles.json')
          .with(body: params.to_json, basic_auth: ['xxxxxxxx', 'x'])
          .to_return(status: 201, body: bundle.to_json)
      end

      it 'return instance of BrickFTP::API::Bundle' do
        is_expected.to be_an_instance_of BrickFTP::API::Bundle
      end

      it 'set attributes' do
        group = subject
        expect(group.id).to eq 221260
        expect(group.code).to eq "a0b1c2d3e"
        expect(group.url).to eq 'https://site.brickftp.com/f/a0b1c2d3e'
        expect(group.user_id).to eq nil
        expect(group.created_at).to eq '2015-11-12T15:49:30-05:00'
        expect(group.paths)
          .to eq([
                   "cloud/images",
                   "backup.zip"
                 ])
      end
    end

    context 'failure' do
      let(:params) { { paths: ['koshigoe'] } }

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/bundles.json')
          .with(basic_auth: ['xxxxxxxx', 'x'])
          .to_return(status: 500, body: { 'error' => 'xxxxxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end
  end

  describe '#destroy' do
    subject { bundle.destroy }

    let(:bundle) { described_class.new(id: 125108) }

    before do
      stub_request(:delete, 'https://koshigoe.brickftp.com/api/rest/v1/bundles/125108.json')
          .with(basic_auth: ['xxxxxxxx', 'x'])
          .to_return(body: '[]')
    end

    it 'return true' do
      is_expected.to eq true
    end
  end
end
