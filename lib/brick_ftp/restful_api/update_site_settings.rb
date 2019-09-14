# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Update site settings
    #
    # @see https://developers.files.com/#update-site-settings Update site settings
    #
    # ### Params
    #
    # PARAMETER                         | TYPE    | DESCRIPTION
    # --------------------------------- | ------- | -----------
    # name                              | string  | Site name
    # subdomain                         | string  | Site subdomain
    # domain                            | string  | Custom domain
    # email                             | string  | Main email for this site
    # bundle_expiration                 | integer | Default Bundle expiration in days
    # overage_notify                    | boolean | Notify site email of overages?
    # welcome_email_enabled             | boolean | Will the welcome email be sent to new users?
    # ask_about_overwrites              | boolean | If false, rename conflicting files instead of asking for overwrite confirmation. Only applies to web interface.
    # show_request_access_link          | boolean | Show request access link for users without access? Currently unused.
    # welcome_email_cc                  | string  | Include this email in welcome emails if enabled
    # welcome_custom_text               | string  | Custom text send in user welcome email
    # language                          | string  | Site default language
    # windows_mode_ftp                  | boolean | Does FTP user Windows emulation mode?
    # default_time_zone                 | string  | Site default time zone
    # desktop_app                       | boolean | Is the desktop app enabled?
    # desktop_app_session_ip_pinning    | boolean | Is desktop app session IP pinning enabled?
    # desktop_app_session_lifetime      | integer | Desktop app session lifetime (in hours)
    # session_expiry                    | integer | Session expiry in hours
    # ssl_required                      | boolean | Is SSL required? Disabling this is insecure.
    # tls_disabled                      | boolean | Is TLS disabled(site setting)?
    # user_lockout                      | boolean | Will users be locked out after incorrect login attempts?
    # user_lockout_tries                | integer | Number of login tries within user_lockout_within hours before users are locked out
    # user_lockout_within               | integer | Number of hours for user lockout window
    # user_lockout_lock_period          | integer | How many hours to lock user out for failed password?
    # include_password_in_welcome_email | boolean | Include password in emails to new users?
    # allowed_file_types                | string  | List of allowed file types
    # allowed_ips                       | string  | List of allowed IP addresses
    # days_to_retain_backups            | integer | Number of days to keep deleted files
    # max_prior_passwords               | integer | Number of prior passwords to disallow
    # password_validity_days            | integer | Number of days password is valid
    # password_min_length               | integer | Shortest password length for users
    # password_require_letter           | boolean | Require a letter in passwords?
    # password_require_mixed            | boolean | Require lower and upper case letters in passwords?
    # password_require_special          | boolean | Require special characters in password?
    # password_require_number           | boolean | Require a number in passwords?
    # sftp_user_root_enabled            | boolean | Use user FTP roots also for SFTP?
    # disable_password_reset            | boolean | Is password reset disabled?
    # immutable_files                   | boolean | Are files protected from modification?
    # session_pinned_by_ip              | boolean | Are sessions locked to the same IP? (i.e. do users need to log in again if they change IPs?)
    # bundle_password_required          | boolean | Do Bundles require password protection?
    # allowed_2fa_method_sms            | boolean | Is SMS two factor authentication allowed?
    # allowed_2fa_method_u2f            | boolean | Is U2F two factor authentication allowed?
    # allowed_2fa_method_totp           | boolean | Is TOTP two factor authentication allowed?
    # allowed_2fa_method_yubi           | boolean | Is yubikey two factor authentication allowed?
    # require_2fa                       | boolean | Require two-factor authentication for all users?
    # color2_top                        | string  | Top bar background color
    # color2_left                       | string  | Page link and button color
    # color2_link                       | string  | Top bar link color
    # color2_text                       | string  | Page link and button color
    # color2_top_text                   | string  | Top bar text color
    # site_header                       | string  | Custom site header text
    # site_footer                       | string  | Custom site footer text
    # login_help_text                   | string  | Login help text
    # icon16                            | object  | Branded icon 16x16
    # icon32                            | object  | Branded icon 32x32
    # icon48                            | object  | Branded icon 48x48
    # icon128                           | object  | Branded icon 128x128
    # logo                              | object  | Branded logo
    # smtp_address                      | string  | SMTP server hostname or IP
    # smtp_authentication               | string  | SMTP server authentication type
    # smtp_from                         | string  | From address to use when mailing through custom SMTP
    # smtp_username                     | string  | SMTP server username
    # smtp_port                         | integer | SMTP server port
    # ldap_enabled                      | boolean | Main LDAP setting: is LDAP enabled?
    # ldap_type                         | string  | LDAP type. Can be active_directory or open_ldap
    # ldap_host                         | string  | LDAP host
    # ldap_host_2                       | string  | LDAP backup host
    # ldap_host_3                       | string  | LDAP backup host
    # ldap_port                         | integer | LDAP port
    # ldap_secure                       | boolean | Use secure LDAP?
    # ldap_username                     | string  | Username for signing in to LDAP server.
    # ldap_username_field               | string  | LDAP username field. Can be SAMAccountName or userPrincipalName
    # ldap_domain                       | string  | Domain name that will be appended to usernames
    # ldap_user_action                  | string  | Should we sync users from LDAP server?
    # ldap_group_action                 | string  | Should we sync groups from LDAP server?
    # ldap_user_include_groups          | string  | Comma or newline separated list of group names (with optional wildcards) - if provided, only users in these groups will be added or synced.
    # ldap_group_exclusion              | string  | Comma or newline separated list of group names (with optional wildcards) to exclude when syncing.
    # ldap_group_inclusion              | string  | Comma or newline separated list of group names (with optional wildcards) to include when syncing.
    # ldap_base_dn                      | string  | Base DN for looking up users in LDAP server
    # opt_out_global                    | boolean | Opt out of global emails?
    # use_provided_modified_at          | boolean | Allow uploaders to set provided_modified_at for uploaded files?
    # custom_namespace                  | boolean | Is this site using a custom namespace for users?
    # days_until_2fa_required           | integer |
    # disable_2fa_with_delay            | boolean |
    # ldap_password_change              | string  | New LDAP password.
    # ldap_password_change_confirmation | string  | Confirm new LDAP password.
    # remove_icons                      | boolean |
    # smtp_password                     | string  |
    #
    class UpdateSiteSettings
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'UpdateSiteSettingsParams',
        :name,
        :subdomain,
        :domain,
        :email,
        :bundle_expiration,
        :overage_notify,
        :welcome_email_enabled,
        :ask_about_overwrites,
        :show_request_access_link,
        :welcome_email_cc,
        :welcome_custom_text,
        :language,
        :windows_mode_ftp,
        :default_time_zone,
        :desktop_app,
        :desktop_app_session_ip_pinning,
        :desktop_app_session_lifetime,
        :session_expiry,
        :ssl_required,
        :tls_disabled,
        :user_lockout,
        :user_lockout_tries,
        :user_lockout_within,
        :user_lockout_lock_period,
        :include_password_in_welcome_email,
        :allowed_file_types,
        :allowed_ips,
        :days_to_retain_backups,
        :max_prior_passwords,
        :password_validity_days,
        :password_min_length,
        :password_require_letter,
        :password_require_mixed,
        :password_require_special,
        :password_require_number,
        :sftp_user_root_enabled,
        :disable_password_reset,
        :immutable_files,
        :session_pinned_by_ip,
        :bundle_password_required,
        :allowed_2fa_method_sms,
        :allowed_2fa_method_u2f,
        :allowed_2fa_method_totp,
        :allowed_2fa_method_yubi,
        :require_2fa,
        :color2_top,
        :color2_left,
        :color2_link,
        :color2_text,
        :color2_top_text,
        :site_header,
        :site_footer,
        :login_help_text,
        :icon16,
        :icon32,
        :icon48,
        :icon128,
        :logo,
        :smtp_address,
        :smtp_authentication,
        :smtp_from,
        :smtp_username,
        :smtp_port,
        :ldap_enabled,
        :ldap_type,
        :ldap_host,
        :ldap_host_2,
        :ldap_host_3,
        :ldap_port,
        :ldap_secure,
        :ldap_username,
        :ldap_username_field,
        :ldap_domain,
        :ldap_user_action,
        :ldap_group_action,
        :ldap_user_include_groups,
        :ldap_group_exclusion,
        :ldap_group_inclusion,
        :ldap_base_dn,
        :opt_out_global,
        :use_provided_modified_at,
        :custom_namespace,
        :days_until_2fa_required,
        :disable_2fa_with_delay,
        :ldap_password_change,
        :ldap_password_change_confirmation,
        :remove_icons,
        :smtp_password,
        keyword_init: true
      )

      # Update site settings
      #
      # @param [BrickFTP::RESTfulAPI::UpdateSiteSettings::Params] params parameters
      # @return [BrickFTP::Types::Site]
      #
      def call(params = {})
        res = client.put('/api/rest/v1/site.json', Params.new(params.to_h).to_h.compact)

        BrickFTP::Types::Site.new(res.symbolize_keys)
      end
    end
  end
end
