# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    class ListPermissions
      include Command

      # Returns a list of permissions on the current site.
      #
      # - By default all permissions for the entire site are returned.
      # - When given a path parameter, then only permissions immediately relevant to the given path are returned.
      # - When using a path parameter, the result will include permissions on the current path and recursive
      #   permissions that are inherited from parent paths, except that lesser permissions will be excluded
      #   if a greater permission applies on the given path for a particular user or group.
      #
      # @param [String] path Folder path for the permission to apply to. This must be slash-delimited,
      #   but it must neither start nor end with a slash. Maximum of 5000 characters.
      # @return [Array<BrickFTP::Types::Permission>] Permissions
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
