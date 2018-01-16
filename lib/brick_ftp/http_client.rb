require 'net/https'
require 'json'
require 'cgi'

module BrickFTP
  class HTTPClient
    class Error < StandardError
      def initialize(response)
        begin
          error = JSON.parse(response.body)
        rescue StandardError
          error = { 'http-code' => response.code, 'error' => "#{response.message}, #{response.body}" }
        end

        case
        when !error.is_a?(Hash)
          super "#{response.code} #{response.message}"
        when error.key?('http-code')
          super "#{error['http-code']}: #{error['error']}"
        when error.key?('errors')
          super error['errors'].join('. ')
        else
          super 'unknown error.'
        end
      end
    end

    USER_AGENT = 'BrickFTP Client/0.1 (https://github.com/koshigoe/brick_ftp)'.freeze

    def initialize(host = nil)
      @host = host || BrickFTP.config.api_host
      @conn = Net::HTTP.new(@host, 443)
      @conn.use_ssl = true
      @conn.open_timeout = BrickFTP.config.open_timeout
      @conn.read_timeout = BrickFTP.config.read_timeout
    end

    def get(path, params: {}, headers: {})
      query = params.map { |k, v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}" }.join('&')
      path = "#{path}?#{query}" unless query.empty?

      case res = request(:get, path, headers: headers)
      when Net::HTTPSuccess
        res.body.nil? || res.body.empty? ? {} : JSON.parse(res.body)
      else
        # TODO: redirect
        raise Error, res
      end
    end

    def post(path, params: {}, headers: {})
      case res = request(:post, path, params: params, headers: headers)
      when Net::HTTPSuccess, Net::HTTPCreated
        res.body.nil? || res.body.empty? ? {} : JSON.parse(res.body)
      else
        # TODO: redirect
        raise Error, res
      end
    end

    def put(path, params: {}, headers: {})
      case res = request(:put, path, params: params, headers: headers)
      when Net::HTTPSuccess
        res.body.nil? || res.body.empty? ? {} : JSON.parse(res.body)
      else
        # TODO: redirect
        raise Error, res
      end
    end

    def delete(path, params: {}, headers: {})
      case res = request(:delete, path, params: params, headers: headers)
      when Net::HTTPSuccess
        true
      else
        # TODO: redirect
        raise Error, res
      end
    end

    private

    def request(method, path, params: {}, headers: {})
      req = Net::HTTP.const_get(method.to_s.capitalize).new(path, headers)
      req['User-Agent'] = USER_AGENT

      if @host == BrickFTP.config.api_host
        req['Content-Type'] = 'application/json'
        case
        when BrickFTP.config.session
          req['Cookie'] = BrickFTP::API::Authentication.cookie(BrickFTP.config.session).to_s
        when BrickFTP.config.api_key
          req.basic_auth(BrickFTP.config.api_key, 'x')
        end
      end

      case
      when params.is_a?(Hash)
        req.body = params.to_json unless params.empty?
      when params.is_a?(IO)
        req.body_stream = params
        req["Content-Length"] = params.size
      end

      start = Time.now
      begin
        logger.debug format('Request headers: %{headers}', headers: req.each_capitalized.map { |k, v| "#{k}: #{v}" })
        logger.debug format('Request body: %{body}', body: req.body)
        @conn.request(req).tap do |res|
          logger.debug format('Response headers: %{headers}', headers: res.each_capitalized.map { |k, v| "#{k}: #{v}" })
          logger.debug format('Response body: %{body}', body: res.body)
        end
      ensure
        logger.info format('Complete %{method} %{path} (%{time} ms)', method: method.upcase, path: path, time: (Time.now - start) * 1000)
      end
    end

    def logger
      BrickFTP.logger
    end
  end
end
