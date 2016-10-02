module BrickFTP
  module API
    class PublicKey < Base
      define_api :index,  '/api/rest/v1/users/%{user_id}/public_keys.json'
      define_api :create, '/api/rest/v1/users/%{user_id}/public_keys.json'
      define_api :delete, '/api/rest/v1/public_keys/%{id}.json'
      define_writable_attributes :title, :public_key
      define_readonly_attributes :id, :fingerprint, :created_at
    end
  end
end
