# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    class CountUsers
      include Command

      # Returns a count of the number of users for the current site.
      #
      # @return [Integer] count
      #
      def call
        res = client.get('/api/rest/v1/users.json?action=count')
        res['data']['count']
      end
    end
  end
end
