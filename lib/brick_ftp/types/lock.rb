# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # The Lock object
    #
    # @see https://developers.files.com/#the-lock-object The Lock object
    #
    # ATTRIBUTE     | TYPE     | DESCRIPTION
    # ------------- | -------- | -----------
    # timeout       | integer  | Lock timeout
    # depth         | string   | Lock depth (0 or infinity)
    # owner         | string   | Owner of lock. This can be any arbitrary string.
    # path          | string   | Path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # scope         | string   | Lock scope(shared or exclusive)
    # token         | string   | Lock token. Use to release lock.
    # type          | string   | Lock type
    # user_id       | integer  | Lock creator user ID
    # username      | string   | Lock creator username
    #
    Lock = Struct.new(
      'Lock',
      :timeout,
      :depth,
      :owner,
      :path,
      :scope,
      :token,
      :type,
      :user_id,
      :username,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
