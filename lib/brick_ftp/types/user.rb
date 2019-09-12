# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # The User object
    #
    # @see https://developers.files.com/#the-user-object The User object
    #
    # ATTRIBUTE               | TYPE      | DESCRIPTION
    # ----------------------- | --------- | -----------
    # id                      | integer   | User ID
    # admin_group_ids         | array     | List of group IDs of which this user is an administrator
    # allowed_ips             | string    | A list of allowed IPs if applicable. Newline delimited
    # attachments_permission  | boolean   | Can the user create Bundles (aka Share Links)? This field will be aliased or renamed in the future to bundles_permission.
    # authenticate_until      | datetime  | Scheduled Date/Time at which user will be deactivated
    # authentication_method   | string    | How is this user authenticated? One of password, ldap, or sso
    # bypass_site_allowed_ips | boolean   | Allow this user to skip site-wide IP blacklists?
    # dav_permission          | boolean   | Can the user connect with WebDAV?
    # email                   | email     | User email address
    # ftp_permission          | boolean   | Can the user access with FTP/FTPS?
    # group_ids               | array     | List of group IDs of which this user is a member
    # language                | string    | Preferred language
    # last_login_at           | datetime  | User's last login time
    # last_protocol_cipher    | string    | The last protocol and cipher used
    # lockout_expires         | datetime  | Time in the future that the user will no longer be locked out if applicable
    # name                    | string    | User's full name
    # notes                   | string    | Any internal notes on the user
    # password_set_at         | datetime  | Last time the user's password was set
    # password_validity_days  | integer   | Number of days to allow user to use the same password
    # public_keys_count       | integer   | Number of public keys associated with this user
    # receive_admin_alerts    | boolean   | Should the user receive admin alerts such a certificate expiration notifications and overages?
    # require_2fa             | boolean   | Is 2fa required to sign in?
    # require_password_change | boolean   | Is a password change required upon next user login?
    # restapi_permission      | boolean   | Can this user access the REST API?
    # self_managed            | boolean   | Does this user manage it's own credentials or is it a shared/bot user?
    # sftp_permission         | boolean   | Can the user access with SFTP?
    # site_admin              | boolean   | Is the user an administrator for this site?
    # ssl_required            | string    | SSL required setting. Can be system_setting, always_require, or never_require.
    # sso_strategy_id         | integer   | SSO (Single Sign On) strategy ID for the user, if applicable.
    # subscribe_to_newsletter | boolean   | Is the user subscribed to the newsletter?
    # externally_managed      | boolean   | Is this user managed by an external source (such as LDAP)?
    # time_zone               | string    | User time zone
    # user_root               | string    | Root folder for FTP (and optionally SFTP if the appropriate site-wide setting is set.) Note that this is not used for API, Desktop, or Web interface.
    # username                | string    | User's username
    #
    User = Struct.new(
      'User',
      :id,
      :admin_group_ids,
      :allowed_ips,
      :attachments_permission,
      :authenticate_until,
      :authentication_method,
      :bypass_site_allowed_ips,
      :dav_permission,
      :email,
      :ftp_permission,
      :group_ids,
      :language,
      :last_login_at,
      :last_protocol_cipher,
      :lockout_expires,
      :name,
      :notes,
      :password_set_at,
      :password_validity_days,
      :public_keys_count,
      :receive_admin_alerts,
      :require_2fa,
      :require_password_change,
      :restapi_permission,
      :self_managed,
      :sftp_permission,
      :site_admin,
      :ssl_required,
      :sso_strategy_id,
      :subscribe_to_newsletter,
      :externally_managed,
      :time_zone,
      :user_root,
      :username,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
