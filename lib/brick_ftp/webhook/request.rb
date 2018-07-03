# frozen_string_literal: true

require 'cgi'

module BrickFTP
  module Webhook
    class Request
      attr_reader :action, :interface, :path, :destination, :at, :username, :type

      def self.from_query_string(query_string)
        params = query_string.split('&').each_with_object({}) do |pair, res|
          key, value = pair.split('=').map { |x| CGI.unescape(x) }
          res[key.to_sym] = value
        end

        new(params)
      end

      def initialize(action: nil, interface: nil, path: nil, destination: nil, at: nil, username: nil, type: nil)
        @action = action
        @interface = interface
        @path = path
        @destination = destination
        @at = at
        @username = username
        @type = type
      end
    end
  end
end
