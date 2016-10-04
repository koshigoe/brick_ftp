require 'logger'

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

    def initialize
      self.subdomain = ENV['BRICK_FTP_SUBDOMAIN']
      self.api_key = ENV['BRICK_FTP_API_KEY']
      self.session = nil
      self.logger = Logger.new(STDOUT)
      self.log_level = Logger::WARN
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
  end
end
