# frozen_string_literal: true

require 'spec_helper'

describe BrickFTP do
  it 'has a version number' do
    expect(BrickFTP::VERSION).not_to be nil
  end

  describe '.config' do
    subject { described_class.config }

    it { is_expected.to be_an_instance_of BrickFTP::Configuration }
  end

  describe '.config=' do
    subject { described_class.config = config }

    context 'pass instance of BrickFTP::Configuration' do
      let(:config) { BrickFTP::Configuration.new }

      it 'replace configuration' do
        expect { subject }.to change(BrickFTP, :config).to(config)
      end
    end

    context 'pass not instance of BrickFTP::Configuration' do
      let(:config) { {} }

      it 'raise TypeError' do
        expect { subject }.to raise_error TypeError
      end
    end
  end

  describe '.configure' do
    it 'yield with config' do
      expect { |b| BrickFTP.configure(&b) }.to yield_with_args(BrickFTP.config)
    end
  end

  describe '.logger' do
    subject { described_class.logger }

    it 'delegate BrickFTP::Configuration#logger' do
      expect(described_class.config).to receive(:logger)
      subject
    end
  end
end
