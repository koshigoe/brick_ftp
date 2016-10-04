module BrickFTP
  module API
    class Behavior < Base
      endpoint :index,  '/api/rest/v1/behaviors.json'
      endpoint :show,   '/api/rest/v1/behaviors/%{id}.json'
      endpoint :create, '/api/rest/v1/behaviors.json'
      endpoint :update, '/api/rest/v1/behaviors/%{id}.json'
      endpoint :delete, '/api/rest/v1/behaviors/%{id}.json'

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
