# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # The Session object
    #
    # @see https://developers.files.com/#the-session-object The Session object
    #
    # ATTRIBUTE                | TYPE    | DESCRIPTION
    # ------------------------ | ------- | -----------
    # id                       | integer | Session ID
    # language                 | string  | Session language
    # login_token              | string  | Login token. If set, this token will allow your user to log in via browser at the domain in login_token_domain.
    # login_token_domain       | string  | Domain to use with login_token.
    # max_dir_listing_size     | integer | Maximum number of files to retrieve per folder for a directory listing. This is based on the user's plan.
    # multiple_regions         | boolean | Can access multiple regions?
    # root_path                | string  | Initial root path to start the user's session in.
    # site_id                  | integer | Site ID
    # ssl_required             | boolean | Is SSL required for this user? (If so, ensure all your communications with this user use SSL.)
    # tls_disabled             | boolean | Is strong TLS disabled for this user? (If this is set to true, the site administrator has signaled that it is ok to use less secure TLS versions for this user.)
    # two_factor_setup_needed  | boolean | If true, this user needs to add a Two Factor Authentication method before performing any further actions.
    # allowed_2fa_method_sms   | boolean | Sent only if 2FA setup is needed. Is SMS two factor authentication allowed?
    # allowed_2fa_method_totp  | boolean | Sent only if 2FA setup is needed. Is TOTP two factor authentication allowed?
    # allowed_2fa_method_u2f   | boolean | Sent only if 2FA setup is needed. Is U2F two factor authentication allowed?
    # allowed_2fa_method_yubi  | boolean | Sent only if 2FA setup is needed. Is Yubikey two factor authentication allowed?
    # use_provided_modified_at | boolean | Allow the user to provide file/folder modified at dates? If false, the server will always use the current date/time.
    # windows_mode_ftp         | boolean | Does this user want to use Windows line-ending emulation? (CR vs CRLF)
    #
    Session = Struct.new(
      'Session',
      :id,
      :language,
      :login_token,
      :login_token_domain,
      :max_dir_listing_size,
      :multiple_regions,
      :root_path,
      :site_id,
      :ssl_required,
      :tls_disabled,
      :two_factor_setup_needed,
      :allowed_2fa_method_sms,
      :allowed_2fa_method_totp,
      :allowed_2fa_method_u2f,
      :allowed_2fa_method_yubi,
      :use_provided_modified_at,
      :windows_mode_ftp,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
