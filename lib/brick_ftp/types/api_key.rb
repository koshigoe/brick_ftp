# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # ## The ApiKey object
    #
    # @see https://developers.files.com/#the-apikey-object The ApiKey object
    #
    # ATTRIBUTE      | TYPE     | DESCRIPTION
    # -------------- | -------- | -----------
    # id             | integer  | API Key ID
    # created_at     | datetime | Time which API Key was created
    # expires_at     | datetime | API Key expiration date
    # key            | string   | API Key actual key string
    # name           | string   | Internal name for the API Key. For your use.
    # permission_set | string   | Permissions for this API Key. Will be either `full` or `desktop_app`. Keys with the `desktop_app` permission set only have the ability to do the functions provided in our Desktop App (File and Share Link operations.) We hope to offer additional permission sets in the future, such as for a Site Admin to give a key with no administrator privileges. If you have ideas for permission sets, please let us know.
    # platform       | string   | If this API key represents a Desktop app, what platform was it created on?
    # user_id        | integer  | User ID for the owner of this API Key. May be blank for Site-wide API Keys.
    #
    APIKey = Struct.new(
      'APIKey',
      :id,
      :created_at,
      :expires_at,
      :key,
      :name,
      :permission_set,
      :platform,
      :user_id,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
