# frozen_string_literal: true

require 'brick_ftp/restful_api'

module BrickFTP
  # To delegate commands.
  #
  # @see BrickFTP::RESTfulAPI
  # @example Call {BrickFTP::RESTfulAPI::ListUser#call}
  #   BrickFTP::Client.new.list_users
  #
  # @!method get_api_key(params)
  #   Show API Key
  #   @param [BrickFTP::RESTfulAPI::GetApiKey::Params] params parameters
  #   @return [BrickFTP::Types::ApiKey]
  #
  # @!method list_current_user_api_keys
  #   List current user's API Keys
  #   @return [Array<BrickFTP::Types::ApiKey>]
  #
  # @!method list_user_api_keys(params)
  #   List user's API keys
  #   @param [BrickFTP::RESTfulAPI::ListUserApiKeys::Params] params parameters
  #   @return [Array<BrickFTP::Types::ApiKey>]
  #
  # @!method list_site_wide_api_keys(params)
  #   List site-wide API Keys
  #   @param [BrickFTP::RESTfulAPI::ListSiteWideApiKeys::Params] params parameters
  #   @return [Array<BrickFTP::Types::ApiKey>]
  #
  # @!method create_current_user_api_key(params)
  #   Create API Key for current user
  #   @param [BrickFTP::RESTfulAPI::CreateCurrentUserApiKey::Params] params parameters
  #   @return [BrickFTP::Types::UserApiKey]
  #
  # @!method create_user_api_key(params)
  #   Create API key for user
  #   @param [BrickFTP::RESTfulAPI::CreateUserApiKey::Params] params parameters
  #   @return [BrickFTP::Types::ApiKey]
  #
  # @!method create_site_wide_api_key(params)
  #   Create site-wide API Key
  #   @param [BrickFTP::RESTfulAPI::CreateSiteWideApiKey::Params] params parameters
  #   @return [BrickFTP::Types::ApiKey]
  #
  # @!method update_current_api_key(params)
  #   Update current API key. (Requires current API connection to be using an API key.)
  #   @param [BrickFTP::RESTfulAPI::UpdateCurrentApiKey::Params] params parameters
  #   @return [BrickFTP::Types::ApiKey]
  #
  # @!method update_api_key(params)
  #   Update API Key
  #   @param [BrickFTP::RESTfulAPI::UpdateApiKey::Params] params parameters
  #   @return [BrickFTP::Types::ApiKey]
  #
  # @!method delete_current_api_key
  #   Delete current API key. (Requires current API connection to be using an API key.)
  #
  # @!method delete_api_key(params)
  #   Delete API Key
  #   @param [BrickFTP::RESTfulAPI::DeleteApiKey::Params] params parameters
  #
  class Client
    attr_reader :subdomain, :api_key, :api_client

    # @param [String] subdomain
    # @param [String] api_key
    def initialize(subdomain: nil, api_key: nil)
      @subdomain = subdomain || ENV['BRICK_FTP_SUBDOMAIN']
      @api_key = api_key || ENV['BRICK_FTP_API_KEY']
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
