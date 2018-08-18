# frozen_string_literal: true

module BrickFTP
  module Commands
    class Client
      OPEN_TIMEOUT = 60
      READ_TIMEOUT = 60
      USER_AGENT = 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)'

      # ref. https://developers.brickftp.com/#errors
      ErrorResponse = Struct.new(
        'RESTfulAPIErrorResponse',
        :error,
        :'http-code',
        :errors,
        keyword_init: true
      )

      class Error < StandardError
        attr_reader :error

        # @param [BrickFTP::Adapters::RESTfulAPI::ErrorResponse] error
        def initialize(error)
          super error.error

          @error = error
        end
      end

      # Initialize REST API client.
      #
      # @param [String] subdomain
      # @param [String] api_key
      #
      def initialize(subdomain, api_key)
        @http = Net::HTTP.new("#{subdomain}.brickftp.com", 443)
        @http.use_ssl = true
        @http.open_timeout = OPEN_TIMEOUT
        @http.read_timeout = READ_TIMEOUT
        @request_headers = {
          'User-Agent' => USER_AGENT,
          'Content-Type' => 'application/json',
        }
        @api_key = api_key
      end

      # Send HTTP request via GET method.
      #
      # @param [String] path the request path including query string.
      # @return [Hash] JSON parsed object.
      #
      def get(path)
        req = Net::HTTP::Get.new(path, @request_headers)
        req.basic_auth(@api_key, 'x')
        res = @http.start { |session| session.request(req) }

        handle_response(res)
      end

      # Send HTTP request via POST method.
      #
      # @param [String] path the request path including query string.
      # @param [Hash, nil] data the request body
      # @return [Hash] JSON parsed object.
      #
      def post(path, data = nil)
        req = Net::HTTP::Post.new(path, @request_headers)
        req.basic_auth(@api_key, 'x')
        req.body = data.to_json unless data.nil?
        res = @http.start { |session| session.request(req) }

        handle_response(res)
      end

      # Send HTTP request via PUT method.
      #
      # @param [String] path the request path including query string.
      # @param [Hash, nil] data the request body
      # @return [Hash] JSON parsed object.
      #
      def put(path, data = nil)
        req = Net::HTTP::Put.new(path, @request_headers)
        req.basic_auth(@api_key, 'x')
        req.body = data.to_json unless data.nil?
        res = @http.start { |session| session.request(req) }

        handle_response(res)
      end

      # Send HTTP request via DELETE method.
      #
      # @param [String] path the request path including query string.
      # @return [Hash] JSON parsed object.
      #
      def delete(path)
        req = Net::HTTP::Delete.new(path, @request_headers)
        req.basic_auth(@api_key, 'x')
        res = @http.start { |session| session.request(req) }

        handle_response(res)
      end

      private

      def handle_response(response)
        case response
        when Net::HTTPSuccess
          parse_success_response(response)
        else
          error = parse_error_response(response)
          raise Error, error
        end
      end

      def parse_success_response(response)
        JSON.parse(response.body)
      end

      def parse_error_response(response)
        parsed = begin
                   JSON.parse(response.body)
                 rescue StandardError
                   {}
                 end
        parsed = {} unless parsed.is_a?(Hash)

        ErrorResponse.new(parsed.symbolize_keys).tap do |e|
          e['http-code'] ||= response.code
          e['error'] ||= response.body
        end
      end
    end
  end
end
