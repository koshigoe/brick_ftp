# frozen_string_literal: true

module BrickFTP
  module Commands
    module RESTful
      def self.included(klass)
        klass.attr_reader :client
      end

      # @param [BrickFTP::REST] rest RESTful API client.
      def initialize(rest)
        @client = rest
      end
    end
  end
end
