# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # The Site object
    #
    # @see https://developers.files.com/#the-site-object The Site object
    #
    # ATTRIBUTE                         | TYPE     | DESCRIPTION
    # --------------------------------- | -------- | -----------
    # allowed_2fa_method_sms            | boolean  | Is SMS two factor authentication allowed?
    # allowed_2fa_method_totp           | boolean  | Is TOTP two factor authentication allowed?
    # allowed_2fa_method_u2f            | boolean  | Is U2F two factor authentication allowed?
    # allowed_2fa_method_yubi           | boolean  | Is yubikey two factor authentication allowed?
    # admin_user_id                     | integer  | User ID for the main site administrator
    # allowed_file_types                | string   | List of allowed file types
    # allowed_ips                       | string   | List of allowed IP addresses
    # ask_about_overwrites              | boolean  | If false, rename conflicting files instead of asking for overwrite confirmation. Only applies to web interface.
    # bundle_expiration                 | integer  | Default Bundle expiration in days
    # bundle_password_required          | boolean  | Do Bundles require password protection?
    # color2_left                       | string   | Page link and button color
    # color2_link                       | string   | Top bar link color
    # color2_text                       | string   | Page link and button color
    # color2_top                        | string   | Top bar background color
    # color2_top_text                   | string   | Top bar text color
    # created_at                        | datetime | Time this site was created
    # currency                          | string   | Preferred currency
    # custom_namespace                  | boolean  | Is this site using a custom namespace for users?
    # days_to_retain_backups            | integer  | Number of days to keep deleted files
    # default_time_zone                 | string   | Site default time zone
    # desktop_app                       | boolean  | Is the desktop app enabled?
    # desktop_app_session_ip_pinning    | boolean  | Is desktop app session IP pinning enabled?
    # desktop_app_session_lifetime      | integer  | Desktop app session lifetime (in hours)
    # disable_notifications             | boolean  | Are notifications disabled?
    # disable_password_reset            | boolean  | Is password reset disabled?
    # domain                            | string   | Custom domain
    # email                             | email    | Main email for this site
    # hipaa                             | boolean  | Is there a signed HIPAA BAA between Files.com and this site?
    # icon128                           | ?        | Branded icon 128x128
    # icon16                            | ?        | Branded icon 16x16
    # icon32                            | ?        | Branded icon 32x32
    # icon48                            | ?        | Branded icon 48x48
    # immutable_files_set_at            | datetime | Can files be modified?
    # include_password_in_welcome_email | boolean  | Include password in emails to new users?
    # language                          | string   | Site default language
    # ldap_base_dn                      | string   | Base DN for looking up users in LDAP server
    # ldap_domain                       | string   | Domain name that will be appended to usernames
    # ldap_enabled                      | boolean  | Main LDAP setting: is LDAP enabled?
    # ldap_group_action                 | string   | Should we sync groups from LDAP server?
    # ldap_group_exclusion              | string   | Comma or newline separated list of group names (with optional wildcards) to exclude when syncing.
    # ldap_group_inclusion              | string   | Comma or newline separated list of group names (with optional wildcards) to include when syncing.
    # ldap_host                         | string   | LDAP host
    # ldap_host_2                       | string   | LDAP backup host
    # ldap_host_3                       | string   | LDAP backup host
    # ldap_port                         | integer  | LDAP port
    # ldap_secure                       | boolean  | Use secure LDAP?
    # ldap_type                         | string   | LDAP type. Can be active_directory or open_ldap
    # ldap_user_action                  | string   | Should we sync users from LDAP server?
    # ldap_user_include_groups          | string   | Comma or newline separated list of group names (with optional wildcards) - if provided, only users in these groups will be added or synced.
    # ldap_username                     | string   | Username for signing in to LDAP server.
    # ldap_username_field               | string   | LDAP username field. Can be SAMAccountName or userPrincipalName
    # login_help_text                   | string   | Login help text
    # logo                              | ?        | Branded logo
    # max_prior_passwords               | integer  | Number of prior passwords to disallow
    # name                              | string   | Site name
    # next_billing_amount               | float    | Next billing amount
    # next_billing_date                 | string   | Next billing date
    # opt_out_global                    | boolean  | Opt out of global emails?
    # overage_notified_at               | datetime | Last time the site was notified about an overage
    # overage_notify                    | boolean  | Notify site email of overages?
    # overdue                           | boolean  | Is this site's billing overdue?
    # password_min_length               | integer  | Shortest password length for users
    # password_require_letter           | boolean  | Require a letter in passwords?
    # password_require_mixed            | boolean  | Require lower and upper case letters in passwords?
    # password_require_number           | boolean  | Require a number in passwords?
    # password_require_special          | boolean  | Require special characters in password?
    # password_validity_days            | integer  | Number of days password is valid
    # phone                             | string   | Site phone number
    # require_2fa                       | boolean  | Require two-factor authentication for all users?
    # require_2fa_stop_time             | datetime | If set, requirement for two-factor authentication has been scheduled to end on this date-time.
    # session                           | ?        | Current session
    # session_pinned_by_ip              | boolean  | Are sessions locked to the same IP? (i.e. do users need to log in again if they change IPs?)
    # sftp_user_root_enabled            | boolean  | Use user FTP roots also for SFTP?
    # show_request_access_link          | boolean  | Show request access link for users without access? Currently unused.
    # site_footer                       | string   | Custom site footer text
    # site_header                       | string   | Custom site header text
    # smtp_address                      | string   | SMTP server hostname or IP
    # smtp_authentication               | string   | SMTP server authentication type
    # smtp_from                         | string   | From address to use when mailing through custom SMTP
    # smtp_port                         | integer  | SMTP server port
    # smtp_username                     | string   | SMTP server username
    # session_expiry                    | integer  | Session expiry in hours
    # ssl_required                      | boolean  | Is SSL required? Disabling this is insecure.
    # subdomain                         | string   | Site subdomain
    # switch_to_plan_date               | datetime | If switching plans, when does the new plan take effect?
    # tls_disabled                      | boolean  | Is TLS disabled(site setting)?
    # trial_days_left                   | integer  | Number of days left in trial
    # trial_until                       | datetime | When does this Site trial expire?
    # updated_at                        | datetime | Last time this Site was updated
    # use_provided_modified_at          | boolean  | Allow uploaders to set provided_modified_at for uploaded files?
    # user                              | ?        | User of current session
    # user_lockout                      | boolean  | Will users be locked out after incorrect login attempts?
    # user_lockout_lock_period          | integer  | How many hours to lock user out for failed password?
    # user_lockout_tries                | integer  | Number of login tries within user_lockout_within hours before users are locked out
    # user_lockout_within               | integer  | Number of hours for user lockout window
    # welcome_custom_text               | string   | Custom text send in user welcome email
    # welcome_email_cc                  | email    | Include this email in welcome emails if enabled
    # welcome_email_enabled             | boolean  | Will the welcome email be sent to new users?
    # windows_mode_ftp                  | boolean  | Does FTP user Windows emulation mode?
    #
    Site = Struct.new(
      'Site',
      :allowed_2fa_method_sms,
      :allowed_2fa_method_totp,
      :allowed_2fa_method_u2f,
      :allowed_2fa_method_yubi,
      :admin_user_id,
      :allowed_file_types,
      :allowed_ips,
      :ask_about_overwrites,
      :bundle_expiration,
      :bundle_password_required,
      :color2_left,
      :color2_link,
      :color2_text,
      :color2_top,
      :color2_top_text,
      :created_at,
      :currency,
      :custom_namespace,
      :days_to_retain_backups,
      :default_time_zone,
      :desktop_app,
      :desktop_app_session_ip_pinning,
      :desktop_app_session_lifetime,
      :disable_notifications,
      :disable_password_reset,
      :domain,
      :email,
      :hipaa,
      :icon128,
      :icon16,
      :icon32,
      :icon48,
      :immutable_files_set_at,
      :include_password_in_welcome_email,
      :language,
      :ldap_base_dn,
      :ldap_domain,
      :ldap_enabled,
      :ldap_group_action,
      :ldap_group_exclusion,
      :ldap_group_inclusion,
      :ldap_host,
      :ldap_host_2,
      :ldap_host_3,
      :ldap_port,
      :ldap_secure,
      :ldap_type,
      :ldap_user_action,
      :ldap_user_include_groups,
      :ldap_username,
      :ldap_username_field,
      :login_help_text,
      :log,
      :max_prior_passwords,
      :name,
      :next_billing_amount,
      :next_billing_date,
      :opt_out_global,
      :overage_notified_at,
      :overage_notify,
      :overdue,
      :password_min_length,
      :password_require_letter,
      :password_require_mixed,
      :password_require_number,
      :password_require_special,
      :password_validity_days,
      :phone,
      :require_2fa,
      :require_2fa_stop_time,
      :session,
      :session_pinned_by_ip,
      :sftp_user_root_enabled,
      :show_request_access_link,
      :site_footer,
      :site_header,
      :smtp_address,
      :smtp_authentication,
      :smtp_from,
      :smtp_port,
      :smtp_username,
      :session_expiry,
      :ssl_required,
      :subdomain,
      :switch_to_plan_date,
      :tls_disabled,
      :trial_days_left,
      :trial_until,
      :updated_at,
      :use_provided_modified_at,
      :user,
      :user_lockout,
      :user_lockout_lock_period,
      :user_lockout_tries,
      :user_lockout_within,
      :welcome_custom_text,
      :welcome_email_cc,
      :welcome_email_enabled,
      :windows_mode_ftp,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
