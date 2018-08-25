# frozen_string_literal: true

require 'net/http'
require 'json'

module BrickFTP
  module RESTfulAPI
    class Client
      using BrickFTP::CoreExt::Struct

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
          'Accept' => 'application/json',
        }
        @api_key = api_key
      end

      # Send HTTP request via GET method.
      #
      # @param [String] path the request path including query string.
      # @param [Hash, nil] headers additional request headers
      # @return [Hash] JSON parsed object.
      #
      def get(path, headers = nil)
        req = Net::HTTP::Get.new(path, (headers || {}).merge(@request_headers))
        req.basic_auth(@api_key, 'x')
        res = @http.start { |session| session.request(req) }

        handle_response(res)
      end

      # Send HTTP request via POST method.
      #
      # @param [String] path the request path including query string.
      # @param [Hash, nil] data the request body
      # @param [Hash, nil] headers additional request headers
      # @return [Hash] JSON parsed object.
      #
      def post(path, data = nil, headers = nil)
        req = Net::HTTP::Post.new(path, (headers || {}).merge(@request_headers))
        req.basic_auth(@api_key, 'x')
        req.body = data.to_json unless data.nil?
        res = @http.start { |session| session.request(req) }

        handle_response(res)
      end

      # Send HTTP request via PUT method.
      #
      # @param [String] path the request path including query string.
      # @param [Hash, nil] data the request body
      # @param [Hash, nil] headers additional request headers
      # @return [Hash] JSON parsed object.
      #
      def put(path, data = nil, headers = nil)
        req = Net::HTTP::Put.new(path, (headers || {}).merge(@request_headers))
        req.basic_auth(@api_key, 'x')
        req.body = data.to_json unless data.nil?
        res = @http.start { |session| session.request(req) }

        handle_response(res)
      end

      # Send HTTP request via PATCH method.
      #
      # @param [String] path the request path including query string.
      # @param [Hash, nil] data the request body
      # @param [Hash, nil] headers additional request headers
      # @return [Hash] JSON parsed object.
      #
      def patch(path, data = nil, headers = nil)
        req = Net::HTTP::Patch.new(path, (headers || {}).merge(@request_headers))
        req.basic_auth(@api_key, 'x')
        req.body = data.to_json unless data.nil?
        res = @http.start { |session| session.request(req) }

        handle_response(res)
      end

      # Send HTTP request via DELETE method.
      #
      # @param [String] path the request path including query string.
      # @param [Hash, nil] headers additional request headers
      # @return [Hash] JSON parsed object.
      #
      def delete(path, headers = nil)
        req = Net::HTTP::Delete.new(path, (headers || {}).merge(@request_headers))
        req.basic_auth(@api_key, 'x')
        res = @http.start { |session| session.request(req) }

        handle_response(res)
      end

      # Upload file.
      #
      # @param [String] http_method Value is `PUT` or `POST`, and is the HTTP method used when uploading the file.
      # @param [String] upload_url The URL where the file is uploaded to.
      # @param [IO] io uploading data
      # @return [Integer] content length
      #
      def upload_file(http_method, upload_url, io)
        raise ArgumentError, "Unsupported HTTP method `#{http_method}`" unless %w[POST PUT].include?(http_method)

        uri = URI.parse(upload_url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme == 'https'
        req = Net::HTTP.const_get(http_method.capitalize).new(uri.request_uri)
        req.body_stream = io
        req['Content-Length'] = io.size
        res = http.start { |session| session.request(req) }

        return io.size if res.is_a?(Net::HTTPSuccess)
        raise Error, parse_error_response(res)
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
