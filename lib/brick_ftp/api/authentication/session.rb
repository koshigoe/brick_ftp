module BrickFTP
  module API
    module Authentication
      class Session < BrickFTP::API::Base
        define_api :create, '/api/rest/v1/sessions.json'
        define_api :delete, '/api/rest/v1/sessions.json'

        attribute :id
        attribute :username, writable: true
        attribute :password, writable: true

        def self.create(params = {})
          super.tap { |x| BrickFTP.config.session = x }
        end

        def destroy
          super.tap do
            @id = nil
            BrickFTP.config.session = nil
          end
        end
      end
    end
  end
end
