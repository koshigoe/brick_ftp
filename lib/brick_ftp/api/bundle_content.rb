module BrickFTP
  module API
    class BundleContent < Base
      endpoint :index, '/api/rest/v1/bundles/folders%{path}'

      attribute :id
      attribute :path
      attribute :type
      attribute :size
      attribute :crc32
      attribute :md5
      attribute :code, writable: true
      attribute :host, writable: true

      def self.all(params, path_params = {})
        params.symbolize_keys!

        path_params[:path] = '' unless path_params.key?(:path)

        data = BrickFTP::HTTPClient.new.post(api_path_for(:index, path_params), params: params)
        data.map { |x| new(x.symbolize_keys) }
      end
    end
  end
end
