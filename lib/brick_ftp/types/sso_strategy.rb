# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # The SsoStrategy object
    #
    # @see https://developers.files.com/#the-ssostrategy-object The SsoStrategy object
    #
    # ATTRIBUTE                        | TYPE    | DESCRIPTION
    # -------------------------------- | ------- | -----------
    # provider                         | string  | Provider name
    # id                               | integer | ID
    # subdomain                        | string  | Subdomain
    # provision_users                  | boolean | Auto-provision users?
    # provision_groups                 | boolean | Auto-provision group membership based on group memberships on the SSO side?
    # provision_group_default          | string  | Comma-separated list of group names for groups to automatically add all auto-provisioned users to.
     # provision_group_exclusion       | string  | Comma-separated list of group names for groups (with optional wildcards) that will be excluded from auto-provisioning.
    # provision_group_inclusion        | string  | Comma-separated list of group names for groups (with optional wildcards) that will be auto-provisioned.
    # provision_group_required         | string  | Comma or newline separated list of group names (with optional wildcards) to require membership for user provisioning.
    # provision_attachments_permission | boolean | Auto-provisioned users get Sharing permission?
    # provision_dav_permission         | boolean | Auto-provisioned users get WebDAV permission?
    # provision_ftp_permission         | boolean | Auto-provisioned users get FTP permission?
    # provision_sftp_permission        | boolean | Auto-provisioned users get SFTP permission?
    # provision_time_zone              | string  | Default time zone for auto provisioned users.
    #
    SsoStrategy = Struct.new(
      'SsoStrategy',
      :provider,
      :id,
      :subdomain,
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
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
