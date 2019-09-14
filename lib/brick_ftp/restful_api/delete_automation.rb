# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete automation
    #
    # @see https://developers.files.com/#delete-automation Delete automation
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Required: Automation ID.
    #
    class DeleteAutomation
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'DeleteAutomationParams',
        :id,
        keyword_init: true
      )

      # Delete automation
      #
      # @param [BrickFTP::RESTfulAPI::DeleteAutomation::Params] params parameters
      #
      def call(params)
        params = params.to_h.compact
        client.delete("/api/rest/v1/automations/#{params.delete(:id)}.json")
        true
      end
    end
  end
end
