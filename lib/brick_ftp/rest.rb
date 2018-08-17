# frozen_string_literal: true

module BrickFTP
  class REST
    OPEN_TIMEOUT = 60
    READ_TIMEOUT = 60
    USER_AGENT = 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)'

    def initialize(subdomain, api_key)
      @http = Net::HTTP.new("#{subdomain}.brickftp.com", 443)
      @http.use_ssl = true
      @http.open_timeout = OPEN_TIMEOUT
      @http.read_timeout = READ_TIMEOUT
      @request_headers = {
        'User-Agent' => USER_AGENT,
      }
      @api_key = api_key
    end

    def get(path)
      req = Net::HTTP::Get.new(path, @request_headers)
      req.basic_auth(@api_key, 'x')
      res = @http.start { |session| session.request(req) }

      JSON.parse(res.body)
    end
  end
end
