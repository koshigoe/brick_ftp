module BrickFTP
  module API
    class PublicKey
      def self.all(user_id)
        data = BrickFTP::HTTPClient.new.get("/api/rest/v1/users/#{user_id}/public_keys.json")
        data.map { |x| new(x.symbolize_keys) }
      end

      def self.create(user_id, title:, public_key:)
        params = { title: title, public_key: public_key }
        data = BrickFTP::HTTPClient.new.post("/api/rest/v1/users/#{user_id}/public_keys.json", params: params)
        new(data.symbolize_keys)
      end

      attr_reader :id, :title, :fingerprint, :created_at

      def initialize(id:, title:, fingerprint:, created_at:)
        @id = id
        @title = title
        @fingerprint = fingerprint
        @created_at = created_at
      end
    end
  end
end
