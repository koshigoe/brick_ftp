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

    def initialize
      self.subdomain = ENV['BRICK_FTP_SUBDOMAIN']
      self.api_key = ENV['BRICK_FTP_API_KEY']
      self.session = nil

      self.logger = Logger.new(STDOUT)
      logger.level = Logger::WARN
    end

    # Host name of API endpoint.
    # @return [String] API host
    def api_host
      "#{subdomain}.brickftp.com"
    end
  end
end
