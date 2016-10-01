require 'net/https'
require 'json'

module BrickFTP
  class HTTPClient
    class Error < StandardError
      def initialize(response)
        error = JSON.parse(response.body)
        super "#{error['http-code']}: #{error['error']}"
      end
    end

    def initialize
      @conn = Net::HTTP.new(BrickFTP.config.api_host, 443)
      @conn.use_ssl = true
    end

    def get(path)
      case res = request(:get, path)
      when Net::HTTPSuccess
        JSON.parse(res.body)
      else
        # TODO: redirect
        raise Error, res
      end
    end

    def post(path, params: {})
      case res = request(:post, path, params: params)
      when Net::HTTPCreated
        JSON.parse(res.body)
      else
        # TODO: redirect
        raise Error, res
      end
    end

    def delete(path)
      case res = request(:delete, path)
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
      req['Content-Type'] = 'application/json'

      case
      when BrickFTP.config.session
        req['Cookie'] = BrickFTP::API::Authentication.cookie(BrickFTP.config.session).to_s
      when BrickFTP.config.api_key
        req.basic_auth(BrickFTP.config.api_key, 'x')
      end

      req.body = params.to_json unless params.empty?

      @conn.request(req)
    end
  end
end
