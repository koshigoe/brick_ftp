module BrickFTP
  module API
    module Authentication
      class Session
        def self.create(username, password)
          params = {
            username: username,
            password: password,
          }
          data = BrickFTP::HTTPClient.new.post('/api/rest/v1/sessions.json', params: params)
          new(id: data['id']).tap { |x| BrickFTP.config.session = x }
        end

        attr_reader :id

        def initialize(id:)
          @id = id
        end

        def destroy
          BrickFTP::HTTPClient.new.delete('/api/rest/v1/sessions.json')
          @id = nil
          BrickFTP.config.session = nil
        end
      end
    end
  end
end
