# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # The Bundle object
    #
    # @see https://developers.files.com/#the-bundle-object The Bundle object
    #
    # ATTRIBUTE          | TYPE     | DESCRIPTION
    # ------------------ | -------- | -----------
    # code               | string   | Bundle code. This code forms the end part of the Public URL.
    # created_at         | datetime | Bundle created at date/time
    # description        | string   | Public description
    # expires_at         | datetime | Bundle expiration date/time
    # paths              | array    | A list of filenames in this bundle
    # id                 | integer  | Bundle ID
    # note               | string   | Bundle internal note
    # password_protected | boolean  | Is this bundle password protected?
    # url                | string   | Public URL of Share Link
    # user_id            | integer  | Bundle creator user ID
    # username           | string   | Bundle creator username
    #
    Bundle = Struct.new(
      'Bundle',
      :code,
      :created_at,
      :description,
      :expires_at,
      :paths,
      :id,
      :note,
      :password_protected,
      :url,
      :user_id,
      :username,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
