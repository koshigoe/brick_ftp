# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    class GetSiteUsage
      include Command

      # Returns site usage
      #
      # @return [BrickFTP::Types::SiteUsage] site usage
      #
      def call
        res = client.get('/api/rest/v1/site/usage.json')

        BrickFTP::Types::SiteUsage.new(res.symbolize_keys)
      end
    end
  end
end
