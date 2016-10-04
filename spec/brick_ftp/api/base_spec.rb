require 'spec_helper'

RSpec.describe BrickFTP::API::Base do
  let(:api) do
    Class.new(described_class)
  end

  describe '.endpoint' do
    it 'define endpoint' do
      api.endpoint :show, '/path/to/resource/%{param1}/%{param2}', :param1, :param2
      expect(api.api[:show]).to eq(path_template: '/path/to/resource/%{param1}/%{param2}', query_keys: %i(param1 param2))
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
end
