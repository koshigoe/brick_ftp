module BrickFTP
  module API
    class Bundle < Base
      endpoint :get,    :index,  '/api/rest/v1/bundles.json'
      endpoint :get,    :show,   '/api/rest/v1/bundles/%{id}.json'
      endpoint :post,   :create, '/api/rest/v1/bundles.json'
      endpoint :delete, :delete, '/api/rest/v1/bundles/%{id}.json'

      attribute :id
      attribute :code
      attribute :url
      attribute :user_id
      attribute :created_at
      attribute :paths, writable: true
    end
  end
end
