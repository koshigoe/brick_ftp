# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    module Command
      def self.included(klass)
        klass.class_eval do
          attr_reader :client
        end
      end

      # Initialize command.
      #
      # @param [BrickFTP::RESTfulAPI::Client] client RESTful API client.
      #
      def initialize(client)
        @client = client
      end
    end
  end
end
