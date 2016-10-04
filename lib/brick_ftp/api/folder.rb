module BrickFTP
  module API
    class Folder < Base
      define_api :index,  '/api/rest/v1/folders/%{path}', :page, :per_page, :search, :'sort_by[path]', :'sort_by[size]', :'sort_by[modified_at_datetime]'
      define_api :create, '/api/rest/v1/folders/%{path}'

      attribute :id
      attribute :path
      attribute :type
      attribute :size
      attribute :mtime
      attribute :crc32
      attribute :md5
      attribute :provided_mtime
      attribute :permissions

      def self.create(params = {})
        super(params)
      end
    end
  end
end
