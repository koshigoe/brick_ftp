require 'logger'
require 'inifile'

module BrickFTP
  class Configuration
    # Subdomain of API endpoint. If not specified, get value from enviroment variable `BRICK_FTP_SUBDOMAIN`.
    # @return [String] subdomain
    attr_accessor :subdomain
    # Access key of API. If not specified, get value from enviroment variable `BRICK_FTP_API_KEY`.
    # @return [String] API access key
    attr_accessor :api_key
    # Authentication session for cookie auth.
    # @return [BrickFTP::API::Authentication::Session] authentication session object.
    attr_accessor :session
    # Logger.
    # @return [Logger] logger
    attr_accessor :logger
    # Log level
    # @return [Integer]
    attr_reader :log_level
    # Log formatter
    # @return [Logger::Formatter]
    attr_reader :log_formatter
    # Open timeout
    # @return [Integer]
    attr_accessor :open_timeout
    # Read timeout
    # @return [Integer]
    attr_accessor :read_timeout

    DEFAULT_OPEN_TIMEOUT = 10
    DEFAULT_READ_TIMEOUT = 30

    DEFAULT_PROFILE = 'global'.freeze
    CONFIG_FILE_PATH = File.expand_path('~/.brick_ftp/config').freeze

    def self.config_file_path
      CONFIG_FILE_PATH
    end

    def initialize(profile: DEFAULT_PROFILE, config_file_path: CONFIG_FILE_PATH)
      load_config_file(config_file_path)

      self.subdomain = inifile[profile]['subdomain'] || ENV['BRICK_FTP_SUBDOMAIN']
      self.api_key = inifile[profile]['api_key'] || ENV['BRICK_FTP_API_KEY']
      self.session = nil
      self.open_timeout = (inifile[profile]['open_timeout'] || DEFAULT_OPEN_TIMEOUT).to_i
      self.read_timeout = (inifile[profile]['read_timeout'] || DEFAULT_READ_TIMEOUT).to_i
      self.logger = Logger.new(STDOUT)
      self.log_level = Logger::WARN
      self.log_formatter = Logger::Formatter.new
      logger.level = log_level
    end

    # Host name of API endpoint.
    # @return [String] API host
    def api_host
      "#{subdomain}.brickftp.com"
    end

    # Set log level to logger object.
    # @param level [Integer] log level.
    def log_level=(level)
      @log_level = level
      logger.level = @log_level
    end

    # Set log formatter to logger object.
    # @param formatter [Logger::Formatter]
    def log_formatter=(formatter)
      @log_formatter = formatter
      logger.formatter = @log_formatter
    end

    private

    attr_reader :inifile

    def load_config_file(config_file_path)
      @inifile = File.exist?(config_file_path) ? IniFile.load(config_file_path) : IniFile.new
    end
  end
end
