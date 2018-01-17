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

        # Upload file.
        #
        # @see https://brickftp.com/docs/rest-api/file-uploading/
        # @param [String] path Remote file path.
        # @param [IO] source Source `data` (not `path`) to upload.
        # @param [Integer] chunk_size Size of chunk to multi-part upload.
        # @return [BrickFTP::API::FileOperation::Upload] An instance of BrickFTP::API::FileOperation::Upload.
        #
        def self.create(path:, source:, chunk_size: nil)
          api_client = BrickFTP::HTTPClient.new
          chunk_io = BrickFTP::Utils::ChunkIO.new(source, chunk_size: chunk_size)

          ref = nil
          params_for_request_upload_url = { action: 'put' }
          upload_info = {}
          chunk_io.each.with_index(1) do |chunk, part|
            params_for_request_upload_url.update(part: part, ref: ref) if part > 1
            upload_info = api_client.post(api_path_for(:create, path: path), params: params_for_request_upload_url)
            ref = upload_info['ref']

            upload_uri = URI.parse(upload_info['upload_uri'])
            upload_client = BrickFTP::HTTPClient.new(upload_uri.host)
            upload_client.put(upload_info['upload_uri'], params: chunk)
          end

          uploaded_info = api_client.post(api_path_for(:create, path: path), params: { action: 'end', ref: ref })

          new(upload_info.merge(uploaded_info).symbolize_keys)
        end
      end
    end
  end
end
