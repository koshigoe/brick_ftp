require 'spec_helper'

RSpec.describe BrickFTP::Configuration, type: :lib do
  before do
    allow(ENV).to receive(:[]).with('BRICK_FTP_SUBDOMAIN').and_return('koshigoe')
    allow(ENV).to receive(:[]).with('BRICK_FTP_API_KEY').and_return('APIKEY')
  end

  describe '#initialize' do
    subject { described_class.new(options) }

    let(:options) { {} }

    context 'inifile does not exist' do
      before { options[:config_file_path] = File.expand_path('../../data/config-not-exist', __FILE__) }

      it 'set profile default value' do
        expect(subject.profile).to eq 'global'
      end

      it 'set subdomain from environment variable' do
        expect(subject.subdomain).to eq 'koshigoe'
      end

      it 'set api_key from environment variable' do
        expect(subject.api_key).to eq 'APIKEY'
      end

      it 'set open_timeout default value' do
        expect(subject.open_timeout).to eq 10
      end

      it 'set read_timeout default value' do
        expect(subject.read_timeout).to eq 30
      end
    end

    context 'inifile exists' do
      before { options[:config_file_path] = File.expand_path('../../data/config', __FILE__) }

      context 'without profile:' do
        it 'set profile default value' do
          expect(subject.profile).to eq 'global'
        end

        it 'set subdomain from global section in config file' do
          expect(subject.subdomain).to eq 'abc'
        end

        it 'set api_key from global section in config file' do
          expect(subject.api_key).to eq 'xxxxx'
        end

        it 'set open_timeout from global section in config file' do
          expect(subject.open_timeout).to eq 1
        end

        it 'set read_timeout from global section in config file' do
          expect(subject.read_timeout).to eq 2
        end
      end

      context 'with profile:' do
        before { options[:profile] = 'test' }

        it 'set profile from argument' do
          expect(subject.profile).to eq 'test'
        end

        it 'set subdomain from specified section in config file' do
          expect(subject.subdomain).to eq 'xyz'
        end

        it 'set api_key from specified section in config file' do
          expect(subject.api_key).to eq 'yyyyy'
        end

        it 'set open_timeout from specified section in config file' do
          expect(subject.open_timeout).to eq 3
        end

        it 'set read_timeout from specified section in config file' do
          expect(subject.read_timeout).to eq 4
        end
      end
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

  describe '#log_level=' do
    let(:configuration) { described_class.new }
    subject { configuration.log_level = Logger::DEBUG }

    it 'store log_level' do
      expect { subject }.to change(configuration, :log_level).from(Logger::WARN).to(Logger::DEBUG)
    end

    it 'change log level of logger' do
      expect { subject }.to change(configuration.logger, :level).from(Logger::WARN).to(Logger::DEBUG)
    end
  end

  describe '#log_formatter=' do
    let(:configuration) { described_class.new }
    let(:formatter) { Logger::Formatter.new }
    subject { configuration.log_formatter = formatter }

    it 'store log_formatter' do
      expect { subject }.to change(configuration, :log_formatter).to(formatter)
    end

    it 'change log formatter of logger' do
      expect { subject }.to change(configuration.logger, :formatter).to(formatter)
    end
  end
end
