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
    attr_reader :base_url, :api_key, :api_client

    # @param [String] base_url
    # @param [String] subdomain (deprecated)
    # @param [String] api_key
    def initialize(base_url: nil, subdomain: nil, api_key: nil)
      if subdomain
        warn('DEPRECATION WARNING: The argument `subdomain:` will be deprecated in a future version.' \
             ' Please use `base_url:` instead.')
      end

      @subdomain = subdomain || ENV['BRICK_FTP_SUBDOMAIN']
      @base_url = base_url || ENV['BRICK_FTP_BASE_URL']
      @api_key = api_key || ENV['BRICK_FTP_API_KEY']
      @api_client = BrickFTP::RESTfulAPI::Client.new(@base_url || @subdomain, @api_key)
    end

    def subdomain
      warn("DEPRECATION WARNING: #{self.class.name}##{__method__} will be deprecated in a future version.")
      @subdomain
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
