# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create new SSO strategy
    #
    # @see https://developers.files.com/#create-new-sso-strategy Create new SSO strategy
    #
    class CreateSsoStrategy
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER                        | TYPE    | DESCRIPTION
      # -------------------------------- | ------- | -----------
      # provider                         | string  | Required: One of the following: `google`, `auth0`, `okta`, `atlassian_oauth2`, `azure_oauth2`, `box_oauth2`, `dropbox_oauth2`, `slack`, `ubuntu`
      # subdomain                        | string  | Subdomain or domain name for your auth provider. Example: `https://[subdomain].okta.com/`
      # client_id                        | string  | OAuth Client ID for your auth provider.
      # client_secret                    | string  | OAuth Client Secret for your auth provider.
      # provision_users                  | boolean | Auto-provision users?
      # provision_groups                 | boolean | Auto-provision group memberships?
      # provision_group_default          | string  | Comma-separated list of group names for groups to automatically add all auto-provisioned users to.
      # provision_group_exclusion        | string  | Comma-separated list of group names for groups (with optional wildcards) that will be excluded from auto-provisioning.
      # provision_group_inclusion        | string  | Comma-separated list of group names for groups (with optional wildcards) that will be auto-provisioned.
      # provision_group_required         | string  | Comma or newline separated list of group names (with optional wildcards) to require membership for user provisioning.
      # provision_attachments_permission | boolean | Provisioned users to get sharing permission?
      # provision_dav_permission         | boolean | Provisioned users to get WebDAV permission?
      # provision_ftp_permission         | boolean | Provisioned users to get FTP permission?
      # provision_sftp_permission        | boolean | Provisioned users to get SFTP permission?
      # provision_time_zone              | string  | Default timezone to use for provisioned users
      Params = Struct.new(
        'CreateSsoStrategyParams',
        :provider,
        :subdomain,
        :client_id,
        :client_secret,
        :provision_users,
        :provision_groups,
        :provision_group_default,
        :provision_group_exclusion,
        :provision_group_inclusion,
        :provision_group_required,
        :provision_attachments_permission,
        :provision_dav_permission,
        :provision_ftp_permission,
        :provision_sftp_permission,
        :provision_time_zone,
        keyword_init: true
      )

      # Create new SSO strategy
      #
      # @param [BrickFTP::RESTfulAPI::CreateSsoStrategy::Params] params parameters
      # @return [BrickFTP::Types::SsoStrategy]
      #
      def call(params = {})
        res = client.post('/api/rest/v1/sso_strategies.json', Params.new(params.to_h).to_h.compact)

        BrickFTP::Types::SsoStrategy.new(res.symbolize_keys)
      end
    end
  end
end
