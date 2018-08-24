# frozen_string_literal: true

require 'brick_ftp/restful_api'

module BrickFTP
  # To delegate commands.
  #
  # @see BrickFTP::RESTfulAPI
  # @example Call {BrickFTP::RESTfulAPI::ListUser#call}
  #   BrickFTP::Client.new.list_users
  #
  class Client
    attr_reader :subdomain, :api_key, :api_client

    # @param [String] subdomain
    # @param [String] api_key
    def initialize(subdomain: nil, api_key: nil)
      @subdomain = ENV.fetch('BRICK_FTP_SUBDOMAIN', subdomain)
      @api_key = ENV.fetch('BRICK_FTP_API_KEY', api_key)
      @api_client = BrickFTP::RESTfulAPI::Client.new(@subdomain, @api_key)
    end

    private

    def command_class(symbol)
      name = symbol.to_s.split('_').map(&:capitalize).join
      return unless BrickFTP::RESTfulAPI.const_defined?(name)

      klass = BrickFTP::RESTfulAPI.const_get(name)
      return unless klass < BrickFTP::RESTfulAPI::Command

      klass
    end

    def respond_to_missing?(symbol, include_private)
      return true if command_class(symbol)
      super
    end

    def method_missing(name, *args)
      klass = command_class(name)
      if klass
        dispatch_command(klass, *args)
      else
        super
      end
    end

    def dispatch_command(klass, *args)
      klass.new(api_client).call(*args)
    end
  end
end
