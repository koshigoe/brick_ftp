require 'spec_helper'

RSpec.describe BrickFTP::API::Base do
  let(:api) do
    Class.new(described_class) do
      endpoint :create, '/path/to/resources'
    end
  end

  describe '.endpoint' do
    it 'define endpoint' do
      api.endpoint :show, '/path/to/resource/%{param1}/%{param2}', :param1, :param2
      expect(api.endpoints[:show]).to eq(path_template: '/path/to/resource/%{param1}/%{param2}', query_keys: %i(param1 param2))
    end
  end

  describe '.attribute' do
    context 'without writable:' do
      subject { api.attribute(:key) }

      it 'register attribute as readonly' do
        expect { subject }.to change { api.readonly_attributes.include?(:key) }.to(true)
      end
    end

    context 'writable: true' do
      subject { api.attribute(:key, writable: true) }

      it 'register attribute as writable' do
        expect { subject }.to change { api.writable_attributes.include?(:key) }.to(true)
      end
    end
  end

  describe '.api_path_for' do
    subject { api.api_path_for(:create, x: 1) }

    it 'delegate api_component_for' do
      expect(api).to receive_message_chain(:api_component_for, :path).with(:create).with(x: 1)
      subject
    end
  end

  describe '.api_component_for' do
    context 'endpoint is registered' do
      it 'return instance of BrickFTP::APIComponent' do
        expect(api.api_component_for(:create)).to be_an_instance_of(BrickFTP::APIComponent)
      end
    end

    context 'endpoint is not registered' do
      it 'raise BrickFTP::API::NoSuchAPI' do
        expect { api.api_component_for(:delete) }.to raise_error(BrickFTP::API::NoSuchAPI)
      end
    end
  end
end
