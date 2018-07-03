# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::API::History::Login, type: :lib do
  before { BrickFTP.config.api_key = 'xxxxxxxx' }

  describe '.all' do
    subject { described_class.all }

    let(:history) do
      [
        {
          'id' => 904_593_281,
          'when' => '2015-10-28T14:03:08-04:00',
          'user_id' => 54_321,
          'username' => 'justice.london',
          'action' => 'login',
          'ip' => '86.75.30.9',
          'interface' => 'web',
          'display' => 'Login',
        },
        {
          'id' => 903_766_417,
          'when' => '2015-10-27T15:06:43-04:00',
          'user_id' => 12_345,
          'username' => 'fred.admin',
          'action' => 'login',
          'ip' => '172.19.113.171',
          'interface' => 'web',
          'display' => 'Login',
        },
      ]
    end

    before do
      stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/history/login.json')
        .with(basic_auth: %w[xxxxxxxx x])
        .to_return(body: history.to_json)
    end

    it 'return Array of BrickFTP::API::History::Login' do
      is_expected.to all(be_an_instance_of(BrickFTP::API::History::Login))
    end

    it 'set attributes' do
      history = subject
      expect(history.first.id).to eq 904_593_281
      expect(history.first.when).to eq '2015-10-28T14:03:08-04:00'
      expect(history.first.user_id).to eq 54_321
      expect(history.first.username).to eq 'justice.london'
      expect(history.first.action).to eq 'login'
      expect(history.first.ip).to eq '86.75.30.9'
      expect(history.first.interface).to eq 'web'
      expect(history.first.display).to eq 'Login'
    end
  end
end
