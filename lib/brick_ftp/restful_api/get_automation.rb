# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Show automation
    #
    # @see https://developers.files.com/#show-automation Show automation
    #
    class GetAutomation
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE    | DESCRIPTION
      # --------- | ------- | -----------
      # id        | integer | Required: Automation ID.
      Params = Struct.new(
        'GetAutomationParams',
        :id,
        keyword_init: true
      )

      # Show automation
      #
      # @param [BrickFTP::RESTfulAPI::GetAutomation::Params] params parameters
      # @return [Array<BrickFTP::Types::Automation>]
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        res = client.get("/api/rest/v1/automations/#{params.delete(:id)}.json")
        return nil if !res || res.empty?

        BrickFTP::Types::Automation.new(res.symbolize_keys)
      end
    end
  end
end
