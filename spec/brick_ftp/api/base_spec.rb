require 'spec_helper'

RSpec.describe BrickFTP::API::Base do
  let(:api) do
    Class.new(described_class)
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
