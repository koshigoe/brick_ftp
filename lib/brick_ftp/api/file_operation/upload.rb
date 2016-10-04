module BrickFTP
  module API
    module FileOperation
      class Upload < BrickFTP::API::Base
        endpoint :post, :create, '/api/rest/v1/files/%{path}'

        attribute :id
        attribute :ref
        attribute :http_method
        attribute :upload_uri
        attribute :partsize
        attribute :part_number
        attribute :available_parts
        attribute :headers
        attribute :parameters
        attribute :send
        attribute :path
        attribute :action
        attribute :ask_about_overwrites
        attribute :type
        attribute :size
        attribute :mtime
        attribute :crc32
        attribute :md5
        attribute :expires
        attribute :next_partsize
        attribute :provided_mtime
        attribute :permission
        attribute :action, writable: true
        attribute :ref, writable: true
        attribute :part, writable: true
        attribute :restart, writable: true

        def self.create(path:, source:)
          api_client = BrickFTP::HTTPClient.new
          step1 = api_client.post(api_path_for(:create, path: path), params: { action: 'put' })

          upload_uri = URI.parse(step1['upload_uri'])
          upload_client = BrickFTP::HTTPClient.new(upload_uri.host)
          upload_client.put(step1['upload_uri'], params: source)

          step3 = api_client.post(api_path_for(:create, path: path), params: { action: 'end', ref: step1['ref'] })

          new(step1.merge(step3).symbolize_keys)
        end
      end
    end
  end
end
