module BrickFTP
  module API
    class Behavior < Base
      define_api :index,  '/api/rest/v1/behaviors.json'
      define_api :show,   '/api/rest/v1/behaviors/%{id}.json'
      define_api :create, '/api/rest/v1/behaviors.json'
      define_api :update, '/api/rest/v1/behaviors/%{id}.json'
      define_api :delete, '/api/rest/v1/behaviors/%{id}.json'

      attribute :id
      attribute :path
      attribute :behavior
      attribute :value
      attribute :path, writable: true
      attribute :behavior, writable: true
      attribute :value, writable: true
    end
  end
end
