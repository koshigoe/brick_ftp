# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # The public key object
    #
    # @see https://developers.files.com/#the-public-key-object The public key object
    #
    # ATTRIBUTE   | TYPE     | DESCRIPTION
    # ----------- | -------- | -----------
    # id          | integer  | Globally unique identifier of each public key. Each public key is given an ID automatically upon creation.
    # title       | string   | Title to identify the public key. For your reference. Maximum of 50 characters.
    # fingerprint | string   | RSA fingerprint of the public key. This property is read-only.
    # public_key  | string   | The public key itself. This property is write-only. It cannot be retrieved via the API.
    # created_at  | datetime | Creation date of the public key. This property is read-only.
    #
    UserPublicKey = Struct.new(
      'UserPublicKey',
      :id,
      :title,
      :fingerprint,
      :created_at,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
