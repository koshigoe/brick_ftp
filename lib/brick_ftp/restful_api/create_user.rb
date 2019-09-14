# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create user
    #
    # @see https://developers.files.com/#create-user Create user
    #
    # ### Params
    #
    # PARAMETER                    | TYPE    | DESCRIPTION
    # ---------------------------- | ------------------------ | -----------
    # change_password              | string  | Used for changing a password on an existing user.
    # change_password_confirmation | string  | Optional, but if provided, we will ensure that it matches the value sent in change_password.
    # email                        | string  | User's email.
    # grant_permission             | string  | Permission to grant on the user root. Can be blank or full, read, write, preview, or history.
    # group_ids                    | string  | A list of group ids to associate this user with. Comma delimited.
    # password                     | string  | User password.
    # password_confirmation        | string  | Optional, but if provided, we will ensure that it matches the value sent in password.
    # allowed_ips                  | string  | A list of allowed IPs if applicable. Newline delimited
    # attachments_permission       | boolean | Can the user create Bundles (aka Share Links)? This field will be aliased or renamed in the future to bundles_permission.
    # authenticate_until           | string  | Scheduled Date/Time at which user will be deactivated
    # authentication_method        | string  | How is this user authenticated? One of password, ldap, or sso
    # bypass_site_allowed_ips      | boolean | Allow this user to skip site-wide IP blacklists?
    # dav_permission               | boolean | Can the user connect with WebDAV?
    # ftp_permission               | boolean | Can the user access with FTP/FTPS?
    # language                     | string  | Preferred language
    # name                         | string  | User's full name
    # notes                        | string  | Any internal notes on the user
    # password_validity_days       | integer | Number of days to allow user to use the same password
    # receive_admin_alerts         | boolean | Should the user receive admin alerts such a certificate expiration notifications and overages?
    # require_password_change      | boolean | Is a password change required upon next user login?
    # restapi_permission           | boolean | Can this user access the REST API?
    # self_managed                 | boolean | Does this user manage it's own credentials or is it a shared/bot user?
    # sftp_permission              | boolean | Can the user access with SFTP?
    # site_admin                   | boolean | Is the user an administrator for this site?
    # ssl_required                 | string  | SSL required setting. Can be system_setting, always_require, or never_require.
    # sso_strategy_id              | integer | SSO (Single Sign On) strategy ID for the user, if applicable.
    # subscribe_to_newsletter      | boolean | Is the user subscribed to the newsletter?
    # time_zone                    | string  | User time zone
    # user_root                    | string  | Root folder for FTP (and optionally SFTP if the appropriate site-wide setting is set.) Note that this is not used for API, Desktop, or Web interface.
    # username                     | string  | User's username
    #
    class CreateUser
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'CreateUserParams',
        :change_password,
        :change_password_confirmation,
        :email,
        :grant_permission,
        :group_ids,
        :password,
        :password_confirmation,
        :allowed_ips,
        :attachments_permission,
        :authenticate_until,
        :authentication_method,
        :bypass_site_allowed_ips,
        :dav_permission,
        :ftp_permission,
        :language,
        :name,
        :notes,
        :password_validity_days,
        :receive_admin_alerts,
        :require_password_change,
        :restapi_permission,
        :self_managed,
        :sftp_permission,
        :site_admin,
        :ssl_required,
        :sso_strategy_id,
        :subscribe_to_newsletter,
        :time_zone,
        :user_root,
        :username,
        keyword_init: true
      )

      # Create user
      #
      # @param [BrickFTP::RESTfulAPI::CreateUser::Params] params parameters for create a user
      # @return [BrickFTP::Types::User]
      #
      def call(params = {})
        res = client.post('/api/rest/v1/users.json', Params.new(params.to_h).to_h.compact)

        BrickFTP::Types::User.new(res.symbolize_keys)
      end
    end
  end
end
