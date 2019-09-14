# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # List site-wide API Keys
    #
    # @see https://developers.files.com/#list-site-wide-api-keys List site-wide API Keys
    #
    # ### Params
    #
    # PARAMETER  | TYPE    | DESCRIPTION
    # ---------- | ------- | -----------
    # with_users | boolean | Shows associated user ids if set.
    #
    class ListSiteWideApiKeys
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'ListSiteWideApiKeysParams',
        :with_users,
        keyword_init: true
      )

      # List site-wide API Keys
      #
      # @param [BrickFTP::RESTfulAPI::ListSiteWideApiKeys::Params] params parameters
      # @return [Array<BrickFTP::Types::ApiKey>]
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        endpoint = '/api/rest/v1/site/api_keys.json'
        query = params.sort.map { |k, v| "#{k}=#{ERB::Util.url_encode(v.to_s)}" }.join('&')
        endpoint += "?#{query}" unless query.empty?
        res = client.get(endpoint)

        res.map { |i| BrickFTP::Types::ApiKey.new(i.symbolize_keys) }
      end
    end
  end
end
