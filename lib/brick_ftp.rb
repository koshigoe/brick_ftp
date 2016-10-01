require "brick_ftp/version"
require 'brick_ftp/configuration'
require 'brick_ftp/http_client'

module BrickFTP
  def self.config
    @config ||= BrickFTP::Configuration.new
  end

  def self.configure
    yield(config)
  end
end
