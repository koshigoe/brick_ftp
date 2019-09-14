# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Show site settings
    #
    # @see https://developers.files.com/#show-site-settings Show site settings
    #
    class GetSiteSettings
      include Command
      using BrickFTP::CoreExt::Hash

      # Show site settings
      #
      # @return [BrickFTP::Types::Site]
      #
      def call
        res = client.get('/api/rest/v1/site.json')

        BrickFTP::Types::Site.new(res.symbolize_keys)
      end
    end
  end
end
