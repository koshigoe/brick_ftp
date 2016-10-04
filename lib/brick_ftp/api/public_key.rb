module BrickFTP
  module API
    class PublicKey < Base
      endpoint :get,    :index,  '/api/rest/v1/users/%{user_id}/public_keys.json'
      endpoint :post,   :create, '/api/rest/v1/users/%{user_id}/public_keys.json'
      endpoint :delete, :delete, '/api/rest/v1/public_keys/%{id}.json'

      attribute :id
      attribute :fingerprint
      attribute :created_at
      attribute :title, writable: true
      attribute :public_key, writable: true
    end
  end
end
