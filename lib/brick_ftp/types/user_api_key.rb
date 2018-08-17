# frozen_string_literal: true

module BrickFTP
  module Types
    # rubocop:disable Metrics/LineLength
    UserAPIKey = Struct.new(
      'UserAPIKey',
      :id,             # integer  | Globally unique identifier of each user API key. Each user API key is given an ID automatically upon creation.
      :key,            # string   | The API key itself. This property is read-only.
      :name,           # string   | Name to identify the user API key. For your reference. Maximum of 100 characters.
      :permission_set, # string   | The permission set for the user API key. Can be desktop_app or full.
      :platform,       # string   | The platform for the user API key. Can be win32, macos, linux, or none. Applies only to API keys with a permission_set of desktop_app.
      :expires_at,     # datetime | The date that this API key is valid through.
      :created_at,     # datetime | Creation date of the user API key. This property is read-only.
      keyword_init: true
    )
    # rubocop:enable Metrics/LineLength
  end
end
