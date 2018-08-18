# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    class DeleteBundle
      include Command

      # Deletes the specified bundle.
      #
      # @param [Integer] id Globally unique identifier of each bundle.
      #
      def call(id)
        client.delete("/api/rest/v1/bundles/#{id}.json")
        true
      end
    end
  end
end
