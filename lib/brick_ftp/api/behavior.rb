module BrickFTP
  module API
    class Behavior < Base
      endpoint :get,    :index,  '/api/rest/v1/behaviors.json'
      endpoint :get,    :show,   '/api/rest/v1/behaviors/%{id}.json'
      endpoint :post,   :create, '/api/rest/v1/behaviors.json'
      endpoint :put,    :update, '/api/rest/v1/behaviors/%{id}.json'
      endpoint :delete, :delete, '/api/rest/v1/behaviors/%{id}.json'

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
