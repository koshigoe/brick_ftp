# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete group
    #
    # @see https://developers.files.com/#delete-group Delete group
    #
    class DeleteGroup
      include Command

      # Delete group
      #
      # @param [Integer] id Group ID.
      #
      def call(id)
        client.delete("/api/rest/v1/groups/#{id}.json")
        true
      end
    end
  end
end
