module BrickFTP
  module API
    class BundleContent < Base
      define_api :index, '/api/rest/v1/bundles/folders%{path}'
      define_writable_attributes :code, :host
      define_readonly_attributes :id, :path, :type, :size, :crc32, :md5

      def self.all(params, path_params = {})
        params.symbolize_keys!
        undefined_attributes = params.keys - writable_attributes
        raise UndefinedAttributesError, undefined_attributes unless undefined_attributes.empty?

        data = BrickFTP::HTTPClient.new.post(api_path_for(:index, path_params), params: params)
        data.map { |x| new(x.symbolize_keys) }
      end
    end
  end
end
