# frozen_string_literal: true

module BrickFTP
  module Types
    SiteUsage = Struct.new(
      'SiteUsage',
      :id,
      :live_current_storage,
      :current_storage,
      :usage_by_top_level_dir,
      :high_water_storage,
      :start_at,
      :end_at,
      :created_at,
      :updated_at,
      :total_uploads,
      :total_downloads,
      keyword_init: true
    )
  end
end
