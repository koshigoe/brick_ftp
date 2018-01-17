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

        def self.step1(path:, ref: nil, part_number: nil)
          api_client = BrickFTP::HTTPClient.new

          params = if ref.nil? || part_number.nil?
            { action: 'put' }
          else
            { action: 'put', ref: ref, part: part_number }
          end

          step1 = api_client.post(api_path_for(:create, path: path), params: params)

          step1.symbolize_keys
        end

        def self.step2(source:, upload_uri:)
          upload_parsed_uri = URI.parse(uploadUri)
          upload_client = BrickFTP::HTTPClient.new(upload_parsed_uri.host)
          upload_client.put(upload_uri, params: source)
        end

        def self.step3(path:, ref:)
          api_client = BrickFTP::HTTPClient.new
          step3 = api_client.post(api_path_for(:create, path: path), params: { action: 'end', ref: ref })

          new(step3.symbolize_keys)
        end
      end
    end
  end
end
