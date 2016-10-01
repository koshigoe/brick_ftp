require 'logger'

module BrickFTP
  class Configuration
    attr_accessor :subdomain
    attr_accessor :api_key
    attr_accessor :logger

    def initialize
      self.subdomain = ENV['BRICK_FTP_SUBDOMAIN']
      self.api_key = ENV['BRICK_FTP_API_KEY']

      self.logger = Logger.new(STDOUT)
      logger.level = Logger::WARN
    end

    def api_host
      "#{subdomain}.brickftp.com"
    end
  end
end
