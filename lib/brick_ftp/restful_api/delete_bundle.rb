# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete bundle
    #
    # @see https://developers.files.com/#delete-bundle Delete bundle
    #
    class DeleteBundle
      include Command

      # Delete bundle
      #
      # @param [Integer] id Bundle ID.
      #
      def call(id)
        client.delete("/api/rest/v1/bundles/#{id}.json")
        true
      end
    end
  end
end
