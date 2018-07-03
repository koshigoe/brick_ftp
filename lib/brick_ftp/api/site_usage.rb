# frozen_string_literal: true

module BrickFTP
  module API
    class SiteUsage < Base
      endpoint :get, :show, '/api/rest/v1/site/usage'

      attribute :id
      attribute :live_current_storage
      attribute :current_storage
      attribute :usage_by_top_level_dir
      attribute :high_water_storage
      attribute :start_at
      attribute :end_at
      attribute :created_at
      attribute :updated_at

      def self.find
        super('')
      end
    end
  end
end
