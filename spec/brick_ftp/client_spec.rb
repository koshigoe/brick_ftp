# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::Client, type: :lib do
  context 'command found' do
    it 'dipatch command' do
      client = BrickFTP::Client.new(subdomain: 'subdomain', api_key: 'api-key')
      id = double

      expect(BrickFTP::RESTfulAPI::GetUser).to receive_message_chain(:new, :call).with(client.api_client).with(id)
      client.get_user(id)
    end
  end

  context 'command not found' do
    it 'raise NoMethodError' do
      client = BrickFTP::Client.new(subdomain: 'subdomain', api_key: 'api-key')

      expect { client.command_not_found }.to raise_error(NoMethodError)
    end
  end
end
