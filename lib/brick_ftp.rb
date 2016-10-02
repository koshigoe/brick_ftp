require 'deep_hash_transform'
require "brick_ftp/version"
require 'brick_ftp/configuration'
require 'brick_ftp/http_client'
require 'brick_ftp/api'
require 'brick_ftp/api/base'
require 'brick_ftp/api/authentication'
require 'brick_ftp/api/authentication/session'
require 'brick_ftp/api/user'
require 'brick_ftp/api/public_key'
require 'brick_ftp/api/group'
require 'brick_ftp/api/permission'
require 'brick_ftp/api/notification'
require 'brick_ftp/api/history'
require 'brick_ftp/api/history/site'
require 'brick_ftp/api/history/login'
require 'brick_ftp/api/history/user'
require 'brick_ftp/api/history/folder'
require 'brick_ftp/api/history/file'
require 'brick_ftp/api/bundle'
require 'brick_ftp/api/bundle_content'
require 'brick_ftp/api/bundle_download'

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
