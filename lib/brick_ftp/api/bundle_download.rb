module BrickFTP
  module API
    class BundleDownload < Base
      endpoint :index, '/api/rest/v1/bundles/files.json'

      attribute :id
      attribute :path
      attribute :type
      attribute :size
      attribute :crc32
      attribute :md5
      attribute :download_uri
      attribute :code, writable: true
      attribute :host, writable: true
      attribute :paths, writable: true

      def self.all(params = {})
        params.symbolize_keys!

        data = BrickFTP::HTTPClient.new.post(
          api_path_for(:index, params),
          params: api_component_for(:index).except_path_and_query(params)
        )
        data.map { |x| new(x.symbolize_keys) }
      end
    end
  end
end
