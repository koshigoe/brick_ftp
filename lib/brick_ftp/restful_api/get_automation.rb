# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Show automation
    #
    # @see https://developers.files.com/#show-automation Show automation
    #
    class GetAutomation
      include Command
      using BrickFTP::CoreExt::Hash

      # Show automation
      #
      # @return [Array<BrickFTP::Types::Automation>]
      #
      def call(id)
        res = client.get("/api/rest/v1/automations/#{id}.json")
        return nil if !res || res.empty?

        BrickFTP::Types::Automation.new(res.symbolize_keys)
      end
    end
  end
end
