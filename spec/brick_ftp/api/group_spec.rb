require 'spec_helper'

RSpec.describe BrickFTP::API::Group, type: :lib do
  before { BrickFTP.config.api_key = 'xxxxxxxx' }

  describe '.all' do
    subject { described_class.all }

    let(:groups) do
      [
        {
          'id' => 3,
          'name' => 'HR',
          'notes' => 'Has access to HR folders only',
          'user_ids' => '',
        },
        {
          'id' => 1,
          'name' => 'Management',
          'notes' => 'Has access to all areas => Ops, HR, and Board',
          'user_ids' => '3',
        },
        {
          'id' => 2,
          'name' => 'Operations',
          'notes' => 'Has access to Ops folders only',
          'user_ids' => '2,9',
        },
      ]
    end

    before do
      stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/groups.json')
        .with(basic_auth: %w[xxxxxxxx x])
        .to_return(body: groups.to_json)
    end

    it 'return Array of BrickFTP::API::Group' do
      is_expected.to all(be_an_instance_of(BrickFTP::API::Group))
    end

    it 'set attributes' do
      groups = subject
      expect(groups.first.id).to eq 3
      expect(groups.first.name).to eq 'HR'
      expect(groups.first.notes).to eq 'Has access to HR folders only'
      expect(groups.first.user_ids).to eq ''
    end
  end

  describe '.find' do
    subject { described_class.find(2) }

    let(:group) do
      {
        'id' => 2,
        'name' => 'Operations',
        'notes' => 'Has access to Ops folders only',
        'user_ids' => '2,10',
      }
    end

    context 'exists' do
      before do
        stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/groups/2.json')
          .with(basic_auth: %w[xxxxxxxx x])
          .to_return(body: group.to_json)
      end

      it 'return instance of BrickFTP::API::Group' do
        is_expected.to be_an_instance_of BrickFTP::API::Group
      end

      it 'set attributes' do
        group = subject
        expect(group.id).to eq 2
        expect(group.name).to eq 'Operations'
        expect(group.notes).to eq 'Has access to Ops folders only'
        expect(group.user_ids).to eq '2,10'
      end
    end

    context 'not exists' do
      before do
        stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/groups/2.json')
          .with(basic_auth: %w[xxxxxxxx x])
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
          'name' => 'Chicago Office',
          'notes' => 'For members of our Chicago Office',
          'user_ids' => '3,7,9',
        }
      end

      let(:group) do
        {
          'id' => 1,
          'name' => 'Chicago Office',
          'notes' => 'For members of our Chicago Office',
          'user_ids' => '3,7,9',
        }
      end

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/groups.json')
          .with(body: params.to_json, basic_auth: %w[xxxxxxxx x])
          .to_return(status: 201, body: group.to_json)
      end

      it 'return instance of BrickFTP::API::Group' do
        is_expected.to be_an_instance_of BrickFTP::API::Group
      end

      it 'set attributes' do
        group = subject
        expect(group.id).to eq 1
        expect(group.name).to eq 'Chicago Office'
        expect(group.notes).to eq 'For members of our Chicago Office'
        expect(group.user_ids).to eq '3,7,9'
      end
    end

    context 'failure' do
      let(:params) { { name: 'koshigoe' } }

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/groups.json')
          .with(basic_auth: %w[xxxxxxxx x])
          .to_return(status: 500, body: { 'error' => 'xxxxxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end
  end

  describe '#update' do
    subject { group.update(params) }

    let(:group) { described_class.new(id: 125_108) }
    let(:params) { { notes: 'New notes' } }

    context 'success' do
      let(:updated_group) do
        {
          'id' => 125_108,
          'name' => 'name',
          'notes' => 'New notes',
          'user_id' => '',
        }
      end

      before do
        stub_request(:put, 'https://koshigoe.brickftp.com/api/rest/v1/groups/125108.json')
          .with(body: params.to_json, basic_auth: %w[xxxxxxxx x])
          .to_return(body: updated_group.to_json)
      end

      it 'return self' do
        is_expected.to eq group
      end

      it 'update attributes' do
        expect { subject }.to change(group, :notes).to('New notes')
      end
    end

    context 'failure' do
      before do
        stub_request(:put, 'https://koshigoe.brickftp.com/api/rest/v1/groups/125108.json')
          .with(basic_auth: %w[xxxxxxxx x])
          .to_return(status: 500, body: { 'error' => 'xxxxxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end
  end

  describe '#destroy' do
    subject { group.destroy }

    let(:group) { described_class.new(id: 125_108) }

    before do
      stub_request(:delete, 'https://koshigoe.brickftp.com/api/rest/v1/groups/125108.json')
        .with(basic_auth: %w[xxxxxxxx x])
        .to_return(body: '[]')
    end

    it 'return true' do
      is_expected.to eq true
    end
  end
end
