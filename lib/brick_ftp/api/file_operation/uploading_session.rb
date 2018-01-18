module BrickFTP
  module API
    module FileOperation
      class UploadingSession < BrickFTP::API::Base
        include Enumerable

        endpoint :post, :create, '/api/rest/v1/files/%{path}'

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
        attribute :expires
        attribute :next_partsize
        attribute :provided_mtime
        attribute :permission

        # Get uploading URL.
        #
        # @see https://brickftp.com/docs/rest-api/file-uploading/
        # @param [String] path Remote file path.
        # @return [BrickFTP::API::FileOperation::UploadingSession] A session object of uploading file.
        #
        def self.create(path:)
          api_client = BrickFTP::HTTPClient.new
          res = api_client.post(api_path_for(:create, path: path), params: { action: 'put' })
          new(res.symbolize_keys)
        end

        # Upload data.
        #
        # @param [String] upload_uri A uplading URL.
        # @param [IO] data An IO object to upload.
        #
        def self.upload(upload_uri:, data:)
          uri = URI.parse(upload_uri)
          upload_client = BrickFTP::HTTPClient.new(uri.host)
          upload_client.put(uri.to_s, params: data)
        end

        # Get uploading URL for multi part uploading.
        #
        # @param [Integer] part_number The part number.
        # @return [BrickFTP::API::FileOperation::UploadingSession] A session object of uploading file.
        #
        def at(part_number)
          params = { action: 'put', ref: ref, part: part_number }
          api_client = BrickFTP::HTTPClient.new
          res = api_client.post(self.class.api_path_for(:create, path: path), params: params)
          self.class.new(res.symbolize_keys)
        end

        # Get each uploading URLs.
        #
        # @yield [session] Gives uploading session object to the block.
        # @yieldparam [BrickFTP::API::FileOperation::UploadingSession] session A session object of uploading file.
        #
        def each
          return enum_for(__method__) unless block_given?

          yield self
          (part_number + 1).upto(available_parts) do |n|
            yield at(n)
          end
        end

        # Complete uploading file.
        #
        # @return [BrickFTP::API::FileOperation::UploadingResult] A result of uploading file.
        #
        def commit
          UploadingResult.create(path: path, ref: ref)
        end
      end
    end
  end
end
