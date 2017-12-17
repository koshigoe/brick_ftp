module BrickFTP
  module API
    class Folder < Base
      endpoint :get,  :index,  '/api/rest/v1/folders/%{path}', :page, :per_page, :search, :'sort_by[path]', :'sort_by[size]', :'sort_by[modified_at_datetime]'
      endpoint :post, :create, '/api/rest/v1/folders/%{path}'

      attribute :id
      attribute :path
      attribute :display_name
      attribute :type
      attribute :size
      attribute :mtime
      attribute :crc32
      attribute :md5
      attribute :provided_mtime
      attribute :permissions
      attribute :subfolders_locked?
    end
  end
end
