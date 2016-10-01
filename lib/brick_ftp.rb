require 'deep_hash_transform'
require "brick_ftp/version"
require 'brick_ftp/configuration'
require 'brick_ftp/http_client'
require 'brick_ftp/api'
require 'brick_ftp/api/authentication'
require 'brick_ftp/api/authentication/session'
require 'brick_ftp/api/user'
require 'brick_ftp/api/public_key'

module BrickFTP
  def self.config
    @config ||= BrickFTP::Configuration.new
  end

  def self.config=(config)
    raise TypeError unless config.is_a?(BrickFTP::Configuration)
    @config = config
  end

  def self.configure
    yield(config)
  end
end
