# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete notification
    #
    # @see https://developers.files.com/#delete-notification Delete notification
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Required: Notification ID.
    #
    class DeleteNotification
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'DeleteNotificationParams',
        :id,
        keyword_init: true
      )

      # Delete notification
      #
      # @param [BrickFTP::RESTfulAPI::DeleteNotification::Params] params parameters
      #
      def call(params)
        params = params.to_h.compact
        client.delete("/api/rest/v1/notifications/#{params.delete(:id)}.json")
        true
      end
    end
  end
end
