# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # The TwoFactorAuthenticationOtp object
    #
    # @see https://developers.files.com/#generate-and-send-if-applicable-a-one-time-password-for-current-user-39-s-primary-2fa-method
    #
    # ATTRIBUTE    | TYPE   | DESCRIPTION
    # ------------ | ------ | -----------
    # app_id       | string |
    # challenge    | string |
    # sign_request | string |
    #
    TwoFactorAuthenticationOtp = Struct.new(
      'TwoFactorAuthenticationOtp',
      :app_id,
      :challenge,
      :sign_request,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
