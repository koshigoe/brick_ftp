# frozen_string_literal: true

module BrickFTP
  module Types
    Bundle = Struct.new(
      'Bundle',
      :id,         # integer  | Globally unique identifier of each bundle.
      :code,       # string   | Unique code string identifier for the bundle.
      :url,        # string   | Public sharing URL for the bundle.
      :user_id,    # integer  | ID of the user that created the bundle.
      :created_at, # datetime | Creation date of the bundle.
      :paths,      # array    | List of the paths associated with the bundle.
      :expires_at, # datetime | <undocumented>
      :username,   # string   | <undocumented>
      keyword_init: true
    )
  end
end
