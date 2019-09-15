# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # List automations
    #
    # @see https://developers.files.com/#list-automations List automations
    #
    class ListAutomations
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER  | TYPE    | DESCRIPTION
      # ---------- | ------- | -----------
      # automation | string  | Type of automation to filter by.
      Params = Struct.new(
        'ListAutomationsParams',
        :automation,
        keyword_init: true
      )

      # List automations
      #
      # @param [BrickFTP::RESTfulAPI::ListAutomations::Params] params parameters
      # @return [Array<BrickFTP::Types::Automation>]
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        query = params.sort.map { |k, v| "#{k}=#{ERB::Util.url_encode(v.to_s)}" }.join('&')
        endpoint = '/api/rest/v1/automations.json'
        endpoint += "?#{query}" unless query.empty?

        res = client.get(endpoint)

        res.map { |i| BrickFTP::Types::Automation.new(i.symbolize_keys) }
      end
    end
  end
end
