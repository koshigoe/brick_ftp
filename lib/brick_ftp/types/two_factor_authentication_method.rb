# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # The TwoFactorAuthenticationMethod object
    #
    # @see https://developers.files.com/#the-twofactorauthenticationmethod-object The TwoFactorAuthenticationMethod object
    #
    # ATTRIBUTE                    | TYPE     | DESCRIPTION
    # ---------------------------- | -------- | -----------
    # id                           | integer  | 2fa ID
    # method_type                  | string   | Type of 2fa. Can be totp, yubi, sms, or u2f
    # name                         | string   | 2fa name
    # phone_number                 | string   | 2fa phone number (if SMS)
    # phone_number_country         | string   | 2fa phone number country (if SMS)
    # phone_number_national_format | string   | 2fa phone number national format (if SMS)
    # setup_expired                | boolean  | 2fa setup expired?
    # setup_complete               | boolean  | 2fa setup complete?
    # setup_expires_at             | datetime | 2fa setup expires at this date/time (typically 10 minutes after a new method is created)
    # totp_provisioning_uri        | string   | TOTP provisioning URI (if TOTP)
    # u2f_app_id                   | string   | U2F app ID (if U2F)
    # u2f_registration_requests    | array    | U2F registration requests (if U2F)
    #
    TwoFactorAuthenticationMethod = Struct.new(
      'TwoFactorAuthenticationMethod',
      :id,
      :method_type,
      :name,
      :phone_number,
      :phone_number_country,
      :phone_number_national_format,
      :setup_expired,
      :setup_complete,
      :setup_expires_at,
      :totp_provisioning_uri,
      :u2f_app_id,
      :u2f_registration_requests,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
