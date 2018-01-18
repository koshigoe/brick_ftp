module BrickFTP
  module API
    module FileOperation
      class UploadingResult < BrickFTP::API::Base
        endpoint :post, :create, '/api/rest/v1/files/%{path}'

        attribute :path
        attribute :type
        attribute :size
        attribute :mtime
        attribute :crc32
        attribute :md5

        def self.create(path:, ref:)
          api_client = BrickFTP::HTTPClient.new
          res = api_client.post(api_path_for(:create, path: path), params: { action: 'end', ref: ref })
          new(res.symbolize_keys)
        end
      end
    end
  end
end
