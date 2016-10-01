require 'spec_helper'

RSpec.describe BrickFTP::Configuration, type: :lib do
  before do
    allow(ENV).to receive(:[]).with('BRICK_FTP_SUBDOMAIN').and_return('koshigoe')
    allow(ENV).to receive(:[]).with('BRICK_FTP_API_KEY').and_return('APIKEY')
  end

  describe '#initialize' do
    subject { described_class.new }

    it 'set subdomain' do
      expect(subject.subdomain).to eq 'koshigoe'
    end

    it 'set api_key' do
      expect(subject.api_key).to eq 'APIKEY'
    end

    it 'initialize session' do
      expect(subject.session).to be_nil
    end

    it 'set logger' do
      expect(subject.logger).to be_an_instance_of(Logger)
    end

    it 'log level is warn' do
      expect(subject.logger.level).to eq Logger::WARN
    end
  end

  describe '#api_host' do
    subject { described_class.new.api_host }
    it { is_expected.to eq 'koshigoe.brickftp.com' }
  end
end
