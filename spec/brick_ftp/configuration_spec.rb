require 'spec_helper'

RSpec.describe BrickFTP::Configuration, type: :lib do
  describe '.default_config_file_path' do
    subject { described_class.default_config_file_path }

    context 'with $HOME' do
      it 'return $HOME/.brick_ftp/config' do
        is_expected.to eq "#{ENV['HOME']}/.brick_ftp/config"
      end
    end

    context 'without $HOME' do
      it 'return nil' do
        expect(File).to receive(:expand_path).with('~/.brick_ftp/config').and_raise(ArgumentError)
        is_expected.to be_nil
      end
    end
  end

  describe '#initialize' do
    subject { described_class.new(options) }

    let(:options) { {} }

    shared_examples_for 'inifile does not exist' do
      context 'with environment variable' do
        around do |example|
          begin
            env = ENV.to_hash
            ENV['BRICK_FTP_SUBDOMAIN'] = 'koshigoe'
            ENV['BRICK_FTP_API_KEY'] = 'APIKEY'
            example.run
          ensure
            ENV.replace(env)
          end
        end

        it 'set subdomain from environment variable' do
          expect(subject.subdomain).to eq 'koshigoe'
        end

        it 'set api_key from environment variable' do
          expect(subject.api_key).to eq 'APIKEY'
        end
      end

      context 'without environment variable' do
        it 'set subdomain nil' do
          expect(subject.subdomain).to be_nil
        end

        it 'set api_key nil' do
          expect(subject.api_key).to be_nil
        end
      end

      it 'set profile default value' do
        expect(subject.profile).to eq 'global'
      end

      it 'set open_timeout default value' do
        expect(subject.open_timeout).to eq 10
      end

      it 'set read_timeout default value' do
        expect(subject.read_timeout).to eq 30
      end
    end

    context 'config file path is wrong' do
      before { options[:config_file_path] = File.expand_path('../data/config-not-exist', __dir__) }
      it_behaves_like 'inifile does not exist'
    end

    context 'config file path is nil' do
      before { options[:config_file_path] = nil }
      it_behaves_like 'inifile does not exist'
    end

    context 'inifile exists' do
      before { options[:config_file_path] = File.expand_path('../data/config', __dir__) }

      context 'without profile:' do
        it 'set profile default value' do
          expect(subject.profile).to eq 'global'
        end

        context 'with environment variable' do
          around do |example|
            begin
              env = ENV.to_hash
              ENV['BRICK_FTP_SUBDOMAIN'] = 'koshigoe'
              ENV['BRICK_FTP_API_KEY'] = 'APIKEY'
              example.run
            ensure
              ENV.replace(env)
            end
          end

          it 'set subdomain from environment variable' do
            expect(subject.subdomain).to eq 'koshigoe'
          end

          it 'set api_key from environment variable' do
            expect(subject.api_key).to eq 'APIKEY'
          end
        end

        context 'without environment variable' do
          it 'set subdomain from global section in config file' do
            expect(subject.subdomain).to eq 'abc'
          end

          it 'set api_key from global section in config file' do
            expect(subject.api_key).to eq 'xxxxx'
          end
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

        context 'with environment variable' do
          around do |example|
            begin
              env = ENV.to_hash
              ENV['BRICK_FTP_SUBDOMAIN'] = 'koshigoe'
              ENV['BRICK_FTP_API_KEY'] = 'APIKEY'
              example.run
            ensure
              ENV.replace(env)
            end
          end

          it 'set subdomain from environment variable' do
            expect(subject.subdomain).to eq 'koshigoe'
          end

          it 'set api_key from environment variable' do
            expect(subject.api_key).to eq 'APIKEY'
          end
        end

        context 'without environment variable' do
          it 'set subdomain from specified section in config file' do
            expect(subject.subdomain).to eq 'xyz'
          end

          it 'set api_key from specified section in config file' do
            expect(subject.api_key).to eq 'yyyyy'
          end
        end

        it 'set profile from argument' do
          expect(subject.profile).to eq 'test'
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

    around do |example|
      begin
        env = ENV.to_hash
        ENV['BRICK_FTP_SUBDOMAIN'] = 'koshigoe'
        example.run
      ensure
        ENV.replace(env)
      end
    end

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

  describe '#save!' do
    subject do
      configuration.save!
    end

    let(:configuration) { described_class.new(profile: 'rspec', config_file_path: config_file_path) }

    around do |example|
      begin
        env = ENV.to_hash
        ENV['BRICK_FTP_SUBDOMAIN'] = 'koshigoe'
        ENV['BRICK_FTP_API_KEY'] = 'APIKEY'
        example.run
      ensure
        ENV.replace(env)
        File.unlink(config_file_path) if File.exist?(config_file_path)
      end
    end

    context 'new file' do
      context 'parent directory exists' do
        let(:config_file_path) { File.expand_path('../data/new-config-file', __dir__) }

        it 'create new config file' do
          expect { subject }.to change { File.exist?(config_file_path) }.to(true)
        end

        context 'unchange attributes' do
          it 'write inifile' do
            subject
            inifile = IniFile.load(config_file_path)
            expect(inifile['rspec']['subdomain']).to be_nil
            expect(inifile['rspec']['api_key']).to be_nil
            expect(inifile['rspec']['open_timeout']).to be_nil
            expect(inifile['rspec']['read_timeout']).to be_nil
          end
        end

        context 'change attributes' do
          before do
            configuration.subdomain = 'abc'
            configuration.api_key = 'api-key'
            configuration.open_timeout = 1
            configuration.read_timeout = 2
          end

          it 'write inifile' do
            subject
            inifile = IniFile.load(config_file_path)
            expect(inifile['rspec']['subdomain']).to eq 'abc'
            expect(inifile['rspec']['api_key']).to eq 'api-key'
            expect(inifile['rspec']['open_timeout']).to eq 1
            expect(inifile['rspec']['read_timeout']).to eq 2
          end
        end
      end

      context 'parent directory does not exist' do
        let(:config_file_path) { File.expand_path('../data/parent/new-config-file', __dir__) }

        after do
          path = File.dirname(config_file_path)
          FileUtils.remove_entry_secure(path) if Dir.exist?(path)
        end

        it 'create new config file' do
          expect { subject }.to change { File.exist?(config_file_path) }.to(true)
        end

        context 'unchange attributes' do
          it 'write inifile' do
            subject
            inifile = IniFile.load(config_file_path)
            expect(inifile['rspec']['subdomain']).to be_nil
            expect(inifile['rspec']['api_key']).to be_nil
            expect(inifile['rspec']['open_timeout']).to be_nil
            expect(inifile['rspec']['read_timeout']).to be_nil
          end
        end

        context 'change attributes' do
          before do
            configuration.subdomain = 'abc'
            configuration.api_key = 'api-key'
            configuration.open_timeout = 1
            configuration.read_timeout = 2
          end

          it 'write inifile' do
            subject
            inifile = IniFile.load(config_file_path)
            expect(inifile['rspec']['subdomain']).to eq 'abc'
            expect(inifile['rspec']['api_key']).to eq 'api-key'
            expect(inifile['rspec']['open_timeout']).to eq 1
            expect(inifile['rspec']['read_timeout']).to eq 2
          end
        end
      end
    end

    context 'exist file' do
      let(:config_file_path) { File.expand_path('../data/exist-config-file', __dir__) }

      before do
        FileUtils.copy File.expand_path('../data/config', __dir__), config_file_path
      end

      context 'unchange attributes' do
        it 'write inifile' do
          subject
          inifile = IniFile.load(config_file_path)
          expect(inifile['rspec']['subdomain']).to be_nil
          expect(inifile['rspec']['api_key']).to be_nil
          expect(inifile['rspec']['open_timeout']).to be_nil
          expect(inifile['rspec']['read_timeout']).to be_nil
        end
      end

      context 'change attributes' do
        before do
          configuration.subdomain = 'abc'
          configuration.api_key = 'api-key'
          configuration.open_timeout = 1
          configuration.read_timeout = 2
        end

        it 'write inifile' do
          subject
          inifile = IniFile.load(config_file_path)
          expect(inifile['rspec']['subdomain']).to eq 'abc'
          expect(inifile['rspec']['api_key']).to eq 'api-key'
          expect(inifile['rspec']['open_timeout']).to eq 1
          expect(inifile['rspec']['read_timeout']).to eq 2
        end
      end

      it 'unchange other sections' do
        subject
        inifile = IniFile.load(config_file_path)

        expect(inifile['global']['subdomain']).to eq 'abc'
        expect(inifile['global']['api_key']).to eq 'xxxxx'
        expect(inifile['global']['open_timeout']).to eq 1
        expect(inifile['global']['read_timeout']).to eq 2

        expect(inifile['test']['subdomain']).to eq 'xyz'
        expect(inifile['test']['api_key']).to eq 'yyyyy'
        expect(inifile['test']['open_timeout']).to eq 3
        expect(inifile['test']['read_timeout']).to eq 4
      end
    end
  end
end
