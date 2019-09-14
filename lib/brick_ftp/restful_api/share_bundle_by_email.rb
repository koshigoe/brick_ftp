# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Send email(s) with a link to bundle
    #
    # @see https://developers.files.com/#send-email-s-with-a-link-to-bundle Send email(s) with a link to bundle
    #
    # ### Params
    #
    # PARAMETER   | TYPE          | DESCRIPTION
    # ----------- | ------------- | -----------
    # id          | integer       | Required: Bundle ID.
    # to          | array(string) | Required: A list of email addresses to share this bundle with.
    # note        | string        | Note to include in email.
    #
    class ShareBundleByEmail
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'ShareBundleByEmailParams',
        :id,
        :to,
        :note,
        keyword_init: true
      )

      # Send email(s) with a link to bundle
      #
      # @param [BrickFTP::RESTfulAPI::CreateBundle::Params] params parameters
      # @return [Boolean]
      #
      def call(params)
        params = Params.new(params.to_h).to_h.compact
        client.post("/api/rest/v1/bundles/#{params.delete(:id)}/share.json", params)
        true
      end
    end
  end
end
