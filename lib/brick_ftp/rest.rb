# frozen_string_literal: true

module BrickFTP
  class REST
    OPEN_TIMEOUT = 60
    READ_TIMEOUT = 60
    USER_AGENT = 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)'

    class Error < StandardError; end

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

    def get(path)
      req = Net::HTTP::Get.new(path, @request_headers)
      req.basic_auth(@api_key, 'x')
      res = @http.start { |session| session.request(req) }

      handle_response(res)
    end

    def post(path, data = nil)
      req = Net::HTTP::Post.new(path, @request_headers)
      req.basic_auth(@api_key, 'x')
      req.body = data.to_json unless data.nil?
      res = @http.start { |session| session.request(req) }

      handle_response(res)
    end

    def put(path, data = nil)
      req = Net::HTTP::Put.new(path, @request_headers)
      req.basic_auth(@api_key, 'x')
      req.body = data.to_json unless data.nil?
      res = @http.start { |session| session.request(req) }

      handle_response(res)
    end

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
        JSON.parse(response.body)
      else
        response.value
      end
    rescue StandardError => e
      raise Error, e.message
    end
  end
end
