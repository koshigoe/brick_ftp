module BrickFTP
  module API
    class FileUpload < Base
      define_api :create, '/api/rest/v1/files/%{path}'
      define_writable_attributes :action, :ref, :part, :restart
      define_readonly_attributes :id,
                                 :ref,
                                 :http_method,
                                 :upload_uri,
                                 :partsize,
                                 :part_number,
                                 :available_parts,
                                 :headers,
                                 :parameters,
                                 :send,
                                 :path,
                                 :action,
                                 :ask_about_overwrites,
                                 :type,
                                 :size,
                                 :mtime,
                                 :crc32,
                                 :md5,
                                 :expires,
                                 :next_partsize,
                                 :provided_mtime,
                                 :permissions

      def self.create(path: , source:)
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
