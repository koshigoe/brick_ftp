# frozen_string_literal: true

module BrickFTP
  module Types
    # The bundle object
    #
    # @see https://developers.brickftp.com/#the-bundle-object The bundle object
    #
    # ATTRIBUTE  | TYPE     | DESCRIPTION
    # ---------- | -------- | -----------
    # id         | integer  | Globally unique identifier of each bundle.
    # code       | string   | Unique code string identifier for the bundle.
    # url        | string   | Public sharing URL for the bundle.
    # user_id    | integer  | ID of the user that created the bundle.
    # created_at | datetime | Creation date of the bundle.
    # paths      | array    | List of the paths associated with the bundle.
    # password   | string   | Optional password to password-protect the bundle. This property is write-only. It cannot be retrieved via the API.
    #
    Bundle = Struct.new(
      'Bundle',
      :id,
      :code,
      :url,
      :user_id,
      :created_at,
      :paths,
      :expires_at,
      :username,
      keyword_init: true
    )
  end
end
