# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    module Command
      def self.included(klass)
        klass.attr_reader :client
      end

      # Initialize command.
      #
      # @param [BrickFTP::REST] rest RESTful API client.
      #
      def initialize(client)
        @client = client
      end
    end
  end
end
