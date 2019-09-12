# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete automation
    #
    # @see https://developers.files.com/#delete-automation Delete automation
    #
    class DeleteAutomation
      include Command

      # Delete automation
      #
      # @param [Integer] Automation ID.
      #
      def call(id)
        client.delete("/api/rest/v1/automations/#{id}.json")
        true
      end
    end
  end
end
