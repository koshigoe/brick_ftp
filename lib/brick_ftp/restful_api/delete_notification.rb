# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete notification
    #
    # @see https://developers.files.com/#delete-notification Delete notification
    #
    class DeleteNotification
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE    | DESCRIPTION
      # --------- | ------- | -----------
      # id        | integer | Required: Notification ID.
      Params = Struct.new(
        'DeleteNotificationParams',
        :id,
        keyword_init: true
      )

      # Delete notification
      #
      # @param [BrickFTP::RESTfulAPI::DeleteNotification::Params] params parameters
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        client.delete("/api/rest/v1/notifications/#{params.delete(:id)}.json")
        true
      end
    end
  end
end
