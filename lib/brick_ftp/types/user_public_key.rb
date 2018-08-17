# frozen_string_literal: true

module BrickFTP
  module Types
    # rubocop:disable Metrics/LineLength
    UserPublicKey = Struct.new(
      'UserPublicKey',
      :id,          # integer  | Globally unique identifier of each public key. Each public key is given an ID automatically upon creation.
      :title,       # string   | Title to identify the public key. For your reference. Maximum of 50 characters.
      :fingerprint, # string   | RSA fingerprint of the public key. This property is read-only.
      :created_at,  # datetime | Creation date of the public key. This property is read-only.
      keyword_init: true
    )
    # rubocop:enable Metrics/LineLength
  end
end
