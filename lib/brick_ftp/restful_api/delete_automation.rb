# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete automation
    #
    # @see https://developers.files.com/#delete-automation Delete automation
    #
    class DeleteAutomation
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE    | DESCRIPTION
      # --------- | ------- | -----------
      # id        | integer | Required: Automation ID.
      Params = Struct.new(
        'DeleteAutomationParams',
        :id,
        keyword_init: true
      )

      # Delete automation
      #
      # @param [BrickFTP::RESTfulAPI::DeleteAutomation::Params] params parameters
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        client.delete("/api/rest/v1/automations/#{params.delete(:id)}.json")
        true
      end
    end
  end
end
