require 'deep_hash_transform'
require "brick_ftp/version"
require 'brick_ftp/configuration'
require 'brick_ftp/log_formatter'
require 'brick_ftp/http_client'
require 'brick_ftp/client'
require 'brick_ftp/api'
require 'brick_ftp/api_component'
require 'brick_ftp/api_definition'
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
require 'brick_ftp/api/behavior'
require 'brick_ftp/api/folder_behavior'
require 'brick_ftp/api/folder'
require 'brick_ftp/api/file'
require 'brick_ftp/api/file_operation'
require 'brick_ftp/api/file_operation/move'
require 'brick_ftp/api/file_operation/copy'
require 'brick_ftp/api/file_operation/upload'
require 'brick_ftp/api/site_usage'
require 'brick_ftp/webhook'
require 'brick_ftp/webhook/request'

module BrickFTP
  # Return configuration.
  # If it has not been configured yet, initialize configuration.
  # @return [BrickFTP::Configuration] configuration object.
  def self.config
    @config ||= BrickFTP::Configuration.new
  end

  # Set configuration.
  #
  # @param config [BrickFTP::Configuration] configuration object.
  # @return [BrickFTP::Configuration] configuration object.
  def self.config=(config)
    raise TypeError unless config.is_a?(BrickFTP::Configuration)
    @config = config
  end

  # Configure some settings.
  #
  # @yield [config] Given configuration object.
  # @yieldparam config [BrickFTP::Configuration] configuration object.
  #
  # @example
  #   BrickFTP.configure do |c|
  #     c.subdomain = 'koshigoe'
  #     c.api_key = 'xxxxxxxxxx'
  #   end
  #
  def self.configure
    yield(config)
  end

  # Return logger object.
  # @return [Logger]
  def self.logger
    config.logger
  end
end
