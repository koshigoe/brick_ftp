# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    class DeletePermission
      include Command

      # Deletes the specified group.
      #
      # @param [Integer] id Globally unique identifier of each permission.
      #   Each permission is given an ID automatically upon creation.
      #
      def call(id)
        client.delete("/api/rest/v1/permissions/#{id}.json")
        true
      end
    end
  end
end
