# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # List behaviors
    #
    # @see https://developers.files.com/#list-behaviors List behaviors
    #
    class ListBehaviors
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER  | TYPE    | DESCRIPTION
      # ---------- | ------- | -----------
      # behavior   | string  | If set, only shows folder behaviors matching this behavior type.
      Params = Struct.new(
        'ListBehaviorsParams',
        :behavior,
        keyword_init: true
      )

      # List behaviors
      #
      # @param [BrickFTP::RESTfulAPI::ListBehavior::Params] params parameters
      # @return [Array<BrickFTP::Types::Behavior>]
      #
      def call(params = {})
        endpoint = '/api/rest/v1/behaviors.json'
        query = Params.new(params.to_h).to_h.compact.map { |k, v| "#{k}=#{ERB::Util.url_encode(v.to_s)}" }.join('&')
        endpoint += "?#{query}" unless query.empty?
        res = client.get(endpoint)

        res.map { |i| BrickFTP::Types::Behavior.new(i.symbolize_keys) }
      end
    end
  end
end
