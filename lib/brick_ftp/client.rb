module BrickFTP
  class Client
    attr_reader :api_key

    def initialize(api_key: nil)
      @api_key = api_key
    end
  end
end
