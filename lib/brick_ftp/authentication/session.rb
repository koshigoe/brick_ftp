module BrickFTP
  module Authentication
    class Session
      def self.create(username, password)
        params = {
          username: username,
          password: password,
        }
        data = BrickFTP::HTTPClient.new.post('/api/rest/v1/sessions.json', params: params)
        new(id: data['id'])
      end

      attr_reader :id

      def initialize(id:)
        @id = id
      end
    end
  end
end
