# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Update API Key
    #
    # @see Update https://developers.files.com/#update-api-key API Key
    #
    # ### Params
    #
    # PARAMETER      | TYPE    | DESCRIPTION
    # -------------- | ------- | -----------
    # id             | integer | Required: API Key ID.
    # name           | string  | Internal name for key. For your reference only.
    # permission_set | string  | Leave blank, or set to desktop_app to restrict the key to only desktop app functions.
    # expires_at     | string  | Have the key expire at this date/time.
    #
    class UpdateAPIKey
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'UpdateAPIKey',
        :id,
        :name,
        :permission_set,
        :expires_at,
        keyword_init: true
      )

      # Update API Key
      #
      # @param [BrickFTP::RESTfulAPI::UpdateAPIKey::Params] params parameters for update API key
      # @return [BrickFTP::Types::APIKey]
      #
      def call(params)
        params = params.to_h.compact
        res = client.patch("/api/rest/v1/api_keys/#{params.delete(:id)}.json", params)

        BrickFTP::Types::APIKey.new(res.symbolize_keys)
      end
    end
  end
end
