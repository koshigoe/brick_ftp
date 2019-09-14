# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # List IP addresses
    #
    # @see https://developers.files.com/#list-ip-addresses List IP addresses
    #
    class ListIpAddresses
      include Command
      using BrickFTP::CoreExt::Hash

      # List IP addresses
      #
      # @return [Array<BrickFTP::Types::IpAddress>]
      #
      def call
        res = client.get('/api/rest/v1/site/ip_addresses.json')

        res.map { |i| BrickFTP::Types::IpAddress.new(i.symbolize_keys) }
      end
    end
  end
end
