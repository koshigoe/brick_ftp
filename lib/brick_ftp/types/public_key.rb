# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # The Public key object
    #
    # @see https://developers.files.com/#the-publickey-object The Public key object
    #
    # ATTRIBUTE   | TYPE     | DESCRIPTION
    # ----------- | -------- | -----------
    # id          | integer  | Public key ID
    # created_at  | datetime | Public key created at date/time
    # fingerprint | string   | Public key fingerprint
    # title       | string   | Public key title
    #
    PublicKey = Struct.new(
      'PublicKey',
      :id,
      :created_at,
      :fingerprint,
      :title,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
