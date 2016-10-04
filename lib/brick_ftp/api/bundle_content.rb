module BrickFTP
  module API
    class BundleContent < Base
      endpoint :post, :index, ->(params) {
        params.key?(:path) ? '/api/rest/v1/bundles/folders/%{path}' : '/api/rest/v1/bundles/folders'
      }

      attribute :id
      attribute :path
      attribute :type
      attribute :size
      attribute :crc32
      attribute :md5
      attribute :code, writable: true
      attribute :host, writable: true
    end
  end
end
