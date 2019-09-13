# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # List permissions
    #
    # @see https://developers.files.com/#list-permissions List permissions
    #
    # ### Params
    #
    # PARAMETER | TYPE   | DESCRIPTION
    # --------- | ------ | -----------
    # path      | string | Permission path.
    #
    class ListPermissions
      include Command
      using BrickFTP::CoreExt::Hash

      # List permissions
      #
      # @param [String] path Permission path.
      # @return [Array<BrickFTP::Types::Permission>]
      #
      def call(path: nil)
        endpoint = '/api/rest/v1/permissions.json'
        endpoint = "#{endpoint}?path=#{ERB::Util.url_encode(path)}" unless path.nil?
        res = client.get(endpoint)

        res.map { |i| BrickFTP::Types::Permission.new(i.symbolize_keys) }
      end
    end
  end
end
