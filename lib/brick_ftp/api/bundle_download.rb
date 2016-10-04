module BrickFTP
  module API
    class BundleDownload < Base
      endpoint :post, :index, '/api/rest/v1/bundles/files.json'

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
    end
  end
end
