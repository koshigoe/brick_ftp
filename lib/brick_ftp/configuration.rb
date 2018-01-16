require 'logger'
require 'inifile'

module BrickFTP
  class Configuration
    # Name of configuration profile.
    # @return [String] profile
    attr_reader :profile
    # Path for configuration file.
    # @return [String] path
    attr_reader :config_file_path
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
    # Name of storable configurations. (TODO: log_path, log_level, log_formatter)
    STORABLE_CONFIGURATION_KEYS = %w[subdomain api_key open_timeout read_timeout].freeze

    STORABLE_CONFIGURATION_KEYS.each do |name|
      define_method("#{name}=") do |value|
        dirty_attributes.add(name)
        instance_variable_set(:"@#{name}", value)
      end
    end

    def self.default_config_file_path
      File.expand_path('~/.brick_ftp/config')
    rescue ArgumentError
      # couldn't find login name -- expanding `~'
      nil
    end
    CONFIG_FILE_PATH = default_config_file_path

    def initialize(profile: DEFAULT_PROFILE, config_file_path: CONFIG_FILE_PATH)
      @profile = profile
      @config_file_path = config_file_path
      load_config_file(config_file_path)

      self.subdomain = ENV.fetch('BRICK_FTP_SUBDOMAIN', inifile[profile]['subdomain'])
      self.api_key = ENV.fetch('BRICK_FTP_API_KEY', inifile[profile]['api_key'])
      self.session = nil
      self.open_timeout = (inifile[profile]['open_timeout'] || DEFAULT_OPEN_TIMEOUT).to_i
      self.read_timeout = (inifile[profile]['read_timeout'] || DEFAULT_READ_TIMEOUT).to_i
      self.logger = Logger.new(STDOUT)
      self.log_level = Logger::WARN
      self.log_formatter = Logger::Formatter.new
      logger.level = log_level

      dirty_attributes.clear
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

    def save!
      dirty_attributes.each do |key|
        inifile[profile][key] = send(key)
      end
      FileUtils.mkdir_p(File.dirname(inifile.filename)) unless File.exist?(File.dirname(inifile.filename))
      inifile.save
    end

    private

    attr_reader :inifile

    def load_config_file(config_file_path)
      @inifile = if config_file_path && File.exist?(config_file_path)
                   IniFile.load(config_file_path, encoding: 'UTF-8')
                 else
                   IniFile.new(filename: config_file_path, encoding: 'UTF-8')
                 end
    end

    def dirty_attributes
      @dirty_attributes ||= Set.new
    end
  end
end
