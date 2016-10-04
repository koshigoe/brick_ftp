module BrickFTP
  module API
    class Bundle < Base
      define_api :index,  '/api/rest/v1/bundles.json'
      define_api :show,   '/api/rest/v1/bundles/%{id}.json'
      define_api :create, '/api/rest/v1/bundles.json'
      define_api :delete, '/api/rest/v1/bundles/%{id}.json'

      attribute :id
      attribute :code
      attribute :url
      attribute :user_id
      attribute :created_at
      attribute :paths, writable: true
    end
  end
end
