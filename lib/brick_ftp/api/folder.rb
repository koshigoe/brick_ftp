# frozen_string_literal: true

module BrickFTP
  module API
    class Folder < Base
      # rubocop:disable Metrics/LineLength
      endpoint :get,  :index,  '/api/rest/v1/folders/%{path}', :page, :per_page, :search, :'sort_by[path]', :'sort_by[size]', :'sort_by[modified_at_datetime]'
      # rubocop:enable Metrics/LineLength
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
