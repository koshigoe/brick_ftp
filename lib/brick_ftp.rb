require "brick_ftp/version"
require 'brick_ftp/configuration'

module BrickFTP
  def self.config
    @config ||= BrickFTP::Configuration.new
  end
end
