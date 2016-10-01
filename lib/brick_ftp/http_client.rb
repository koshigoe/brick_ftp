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

    def post(path, params: {})
      req = Net::HTTP::Post.new(path)
      req['Content-Type'] = 'application/json'
      req.body = params.to_json

      case res = @conn.request(req)
      when Net::HTTPCreated
        JSON.parse(res.body)
      else
        # TODO: redirect
        raise Error, res
      end
    end
  end
end
