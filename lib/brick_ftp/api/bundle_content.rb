module BrickFTP
  module API
    class BundleContent < Base
      endpoint :index, '/api/rest/v1/bundles/folders'
      endpoint :index_with_path, '/api/rest/v1/bundles/folders/%{path}'

      attribute :id
      attribute :path
      attribute :type
      attribute :size
      attribute :crc32
      attribute :md5
      attribute :code, writable: true
      attribute :host, writable: true

      def self.all(params = {})
        params.symbolize_keys!

        name = params.key?(:path) ? :index_with_path : :index
        data = BrickFTP::HTTPClient.new.post(
          api_path_for(name, params),
          params: api_component_for(name).except_path_and_query(params)
        )
        data.map { |x| new(x.symbolize_keys) }
      end
    end
  end
end
