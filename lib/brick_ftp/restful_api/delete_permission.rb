# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete permission
    #
    # @see https://developers.files.com/#delete-permission Delete permission
    #
    class DeletePermission
      include Command

      # Delete permission
      #
      # @param [Integer] id Permission ID.
      #
      def call(id)
        client.delete("/api/rest/v1/permissions/#{id}.json")
        true
      end
    end
  end
end
