module BrickFTP
  module API
    class Bundle < Base
      define_api :index,  '/api/rest/v1/bundles.json'
      define_api :show,   '/api/rest/v1/bundles/%{id}.json'
      define_api :create, '/api/rest/v1/bundles.json'
      define_api :delete, '/api/rest/v1/bundles/%{id}.json'
      define_writable_attributes :paths
      define_readonly_attributes :id, :code, :url, :user_id, :created_at
    end
  end
end
