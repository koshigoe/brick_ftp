# frozen_string_literal: true

require 'brick_ftp/restful_api'

module BrickFTP
  # To delegate commands.
  #
  # @see BrickFTP::RESTfulAPI
  # @example Call {BrickFTP::RESTfulAPI::ListUser#call}
  #   BrickFTP::Client.new.list_users
  #
  # @!method get_api_key(params)
  #   Show API Key
  #   @param [BrickFTP::RESTfulAPI::GetApiKey::Params] params parameters
  #   @return [BrickFTP::Types::ApiKey]
  #
  # @!method list_current_user_api_keys
  #   List current user's API Keys
  #   @return [Array<BrickFTP::Types::ApiKey>]
  #
  # @!method list_user_api_keys(params)
  #   List user's API keys
  #   @param [BrickFTP::RESTfulAPI::ListUserApiKeys::Params] params parameters
  #   @return [Array<BrickFTP::Types::ApiKey>]
  #
  # @!method list_site_wide_api_keys(params)
  #   List site-wide API Keys
  #   @param [BrickFTP::RESTfulAPI::ListSiteWideApiKeys::Params] params parameters
  #   @return [Array<BrickFTP::Types::ApiKey>]
  #
  # @!method create_current_user_api_key(params)
  #   Create API Key for current user
  #   @param [BrickFTP::RESTfulAPI::CreateCurrentUserApiKey::Params] params parameters
  #   @return [BrickFTP::Types::UserApiKey]
  #
  # @!method create_user_api_key(params)
  #   Create API key for user
  #   @param [BrickFTP::RESTfulAPI::CreateUserApiKey::Params] params parameters
  #   @return [BrickFTP::Types::ApiKey]
  #
  # @!method create_site_wide_api_key(params)
  #   Create site-wide API Key
  #   @param [BrickFTP::RESTfulAPI::CreateSiteWideApiKey::Params] params parameters
  #   @return [BrickFTP::Types::ApiKey]
  #
  # @!method update_current_api_key(params)
  #   Update current API key. (Requires current API connection to be using an API key.)
  #   @param [BrickFTP::RESTfulAPI::UpdateCurrentApiKey::Params] params parameters
  #   @return [BrickFTP::Types::ApiKey]
  #
  # @!method update_api_key(params)
  #   Update API Key
  #   @param [BrickFTP::RESTfulAPI::UpdateApiKey::Params] params parameters
  #   @return [BrickFTP::Types::ApiKey]
  #
  # @!method delete_current_api_key
  #   Delete current API key. (Requires current API connection to be using an API key.)
  #
  # @!method delete_api_key(params)
  #   Delete API Key
  #   @param [BrickFTP::RESTfulAPI::DeleteApiKey::Params] params parameters
  #
  # @!method list_automations(params)
  #   List automations
  #   @param [BrickFTP::RESTfulAPI::ListAutomations::Params] params parameters
  #   @return [Array<BrickFTP::Types::Automation>]
  #
  # @!method get_automation(params)
  #   Show automation
  #   @param [BrickFTP::RESTfulAPI::GetAutomation::Params] params parameters
  #   @return [Array<BrickFTP::Types::Automation>]
  #
  # @!method create_automation(params)
  #   Create automation
  #   @param [BrickFTP::RESTfulAPI::CreateAutomation::Params] params parameters
  #   @return [BrickFTP::Types::Automation]
  #
  # @!method update_automation(params)
  #   Update automation
  #   @param [BrickFTP::RESTfulAPI::CreateAutomation::Params] params parameters
  #   @return [BrickFTP::Types::Automation]
  #
  # @!method delete_automation(params)
  #   Delete automation
  #   @param [BrickFTP::RESTfulAPI::DeleteAutomation::Params] params parameters
  #
  # @!method list_behaviors(params)
  #   List behaviors
  #   @param [BrickFTP::RESTfulAPI::ListBehavior::Params] params parameters
  #   @return [Array<BrickFTP::Types::Behavior>]
  #
  # @!method list_folder_behaviors(params)
  #   List behaviors by path
  #   @param [BrickFTP::RESTfulAPI::ListFolderBehaviors::Params] params parameters
  #   @return [Array<BrickFTP::Types::Behavior>]
  #
  # @!method get_behavior(params)
  #   Show behavior
  #   @param [BrickFTP::RESTfulAPI::GetBehavior::Params] params parameters
  #   @return [BrickFTP::Types::Behavior, nil] found Behavior or nil
  #
  # @!method create_behavior(params)
  #   Create behavior
  #   @param [BrickFTP::RESTfulAPI::CreateBehavior::Params] params parameters
  #   @return [BrickFTP::Types::Behavior]
  #
  # @!method update_behavior(params)
  #   Update behavior
  #   @param [BrickFTP::RESTfulAPI::UpdateBehavior::Params] params parameters
  #   @return [BrickFTP::Types::Behavior]
  #
  # @!method delete_behavior(params)
  #   Delete behavior
  #   @param [BrickFTP::RESTfulAPI::DeleteBehavior::Params] params parameters
  #
  # @!method list_bundles
  #   List bundles
  #   @return [Array<BrickFTP::Types::Bundle>]
  #
  # @!method get_bundle(params)
  #   Show bundle
  #   @param [BrickFTP::RESTfulAPI::GetBundle::Params] params parameters
  #   @return [BrickFTP::Types::Bundle]
  #
  # @!method create_bundle(params)
  #   Create bundle
  #   @param [BrickFTP::RESTfulAPI::CreateBundle::Params] params parameters
  #   @return [BrickFTP::Types::Bundle]
  #
  # @!method share_bundle_by_email(params)
  #   Send email(s) with a link to bundle
  #   @param [BrickFTP::RESTfulAPI::ShareBundleByEmail::Params] params parameters
  #   @return [Boolean]
  #
  # @!method delete_bundle(params)
  #   Delete bundle
  #   @param [BrickFTP::RESTfulAPI::DeleteBundle::Params] params parameters
  #
  # @!method list_certificates
  #   List SSL Certificates
  #   @return [Array<BrickFTP::Types::Certificate>]
  #
  # @!method get_certificate(params)
  #   Show SSL Certificate
  #   @param [BrickFTP::RESTfulAPI::GetCertificate::Params] params parameters
  #   @return [BrickFTP::Types::Certificate]
  #
  # @!method create_certificate(params)
  #   Create CSR or import existing SSL Certificate
  #   @param [BrickFTP::RESTfulAPI::CreateCertificate::Params] params parameters
  #   @return [BrickFTP::Types::::Params]
  #
  # @!method deactivate_certificate(params)
  #   Deactivate SSL Certificate
  #   @param [BrickFTP::RESTfulAPI::DeactivateCertificate::Params] params parameters
  #   @return [Boolean]
  #
  # @!method activate_certificate(params)
  #   Activate SSL Certificate
  #   @param [BrickFTP::RESTfulAPI::CreateCertificate::Params] params parameters
  #   @return [Boolean]
  #
  # @!method update_certificate(params)
  #   Update SSL Certificate
  #   @param [BrickFTP::RESTfulAPI::UpdateCertificate::Params] params parameters
  #   @return [BrickFTP::Types::Certificate]
  #
  # @!method delete_certificate(params)
  #   Delete SSL Certificate
  #   @param [BrickFTP::RESTfulAPI::DeleteCertificate::::Params] params parameters
  #
  # @!method download_file(params)
  #   Download file
  #   @param [BrickFTP::RESTfulAPI::DownloadFile::Params] params parameters
  #   @return [BrickFTP::Types::File]
  #
  # @!method upload_file(params)
  #   Upload file
  #   @param [BrickFTP::RESTfulAPI::UploadFile::Params] params parameters
  #   @return [BrickFTP::Types::File]
  #
  # @!method update_file_metadata(params)
  #   Update file/folder metadata
  #   @param [BrickFTP::RESTfulAPI::UpdateFileMetadata::Params] params parameters
  #   @return [BrickFTP::Types::File]
  #
  # @!method delete_folder(params)
  #   Delete file/folder
  #   @param [BrickFTP::RESTfulAPI::DeleteFolder::Params] params parameters
  #
  # @!method list_folder(params)
  #   List folder
  #   @param [BrickFTP::RESTfulAPI::ListFolders::Params] params parameters
  #   @return [Array<BrickFTP::Types::File>]
  #
  # @!method create_folder(params)
  #   Create folder
  #   @param [BrickFTP::RESTfulAPI::CreateFolder::Params] params parameters
  #
  # @!method start_upload(params)
  #   Starting a new upload
  #   @param [BrickFTP::RESTfulAPI::StartUpload::Params] params parameters
  #   @return [BrickFTP::Types::Upload]
  #
  # @!method continue_upload(params)
  #   Uploading the file or file parts
  #   @param [BrickFTP::RESTfulAPI::ContinueUpload::Params] params parameters
  #   @return [BrickFTP::Types::Upload]
  #
  # @!method complete_upload(params)
  #   Completing an upload
  #   @param [BrickFTP::RESTfulAPI::CompleteUpload::Params] params parameters
  #   @return [BrickFTP::Types::File]
  #
  # @!method list_groups
  #   List groups
  #   @return [Array<BrickFTP::Types::Group>]
  #
  # @!method get_group(params)
  #   Show group
  #   @param [BrickFTP::RESTfulAPI::GetGroup::Params] params parameters
  #   @return [BrickFTP::Types::Group, nil]
  #
  # @!method create_group(params)
  #   Create group
  #   @param [BrickFTP::RESTfulAPI::CreateGroup::Params] params parameters
  #   @return [BrickFTP::Types::Group]
  #
  # @!method update_group(params)
  #   Update group
  #   @param [BrickFTP::RESTfulAPI::UpdateGroup::Params] params parameters
  #   @return [BrickFTP::Types::Group]
  #
  # @!method add_group_member(params)
  #   Add a User to a Group
  #   @param [BrickFTP::RESTfulAPI::AddGroupMember::Params] params parameters
  #   @return [BrickFTP::Types::GroupMembership]
  #
  # @!method update_group_member(params)
  #   Update group membership
  #   @param [BrickFTP::RESTfulAPI::UpdateGroupMember::Params] params parameters
  #   @return [BrickFTP::Types::GroupMembership]
  #
  # @!method delete_group(params)
  #   Delete group
  #   @param [BrickFTP::RESTfulAPI::DeleteGroup::Params] params parameters
  #
  # @!method remove_group_member(params)
  #   Delete group membership
  #   @param [BrickFTP::RESTfulAPI::RemoveGroupMember::Params] params parameters
  #
  # @!method retrieve_file_history(params)
  #   List history for specific file
  #   @param [BrickFTP::RESTfulAPI::RetrieveFileHistory::Params] params parameters
  #   @return [Array<BrickFTP::Types::History>]
  #
  # @!method retrieve_folder_history(params)
  #   List history for specific folder
  #   @param [BrickFTP::RESTfulAPI::RetrieveFolderHistory::Params] params parameters
  #   @return [Array<BrickFTP::Types::History>]
  #
  # @!method retrieve_user_history(params)
  #   List history for specific user
  #   @param [BrickFTP::RESTfulAPI::RetrieveUserHistory::Params] params parameters
  #   @return [Array<BrickFTP::Types::History>]
  #
  # @!method retrieve_login_history(params)
  #   List site login history
  #   @param [BrickFTP::RESTfulAPI::RetrieveLoginHistory::Params] params parameters
  #   @return [Array<BrickFTP::Types::History>]
  #
  # @!method retrieve_site_history(params)
  #   List site actions history
  #   @param [BrickFTP::RESTfulAPI::RetrieveSiteHistory::Params] params parameters
  #   @return [Array<BrickFTP::Types::History>]
  #
  # @!method list_locks(params)
  #   List locks at path
  #   @param [BrickFTP::RESTfulAPI::ListLocks::Params] params parameters
  #   @return [Array<BrickFTP::Types::Lock>]
  #
  # @!method create_lock(params)
  #   Create lock
  #   @param [BrickFTP::RESTfulAPI::CreateLock::Params] params parameters
  #   @return [BrickFTP::Types::Lock]
  #
  # @!method delete_lock(params)
  #   Delete lock
  #   @param [BrickFTP::RESTfulAPI::DeleteLock::Params] params parameters
  #
  # @!method list_notifications
  #   List notifications
  #   @return [Array<BrickFTP::Types::Notification>]
  #
  # @!method create_notification(params)
  #   Create notification
  #   @param [BrickFTP::RESTfulAPI::CreateNotification::Params] params parameters
  #   @return [BrickFTP::Types::Notification]
  #
  # @!method delete_notification(params)
  #   Delete notification
  #   @param [BrickFTP::RESTfulAPI::DeleteNotification::Params] params parameters
  #
  # @!method list_permissions(params)
  #   List permissions
  #   @param [BrickFTP::RESTfulAPI::ListPermissions::Params] params parameters
  #   @return [Array<BrickFTP::Types::Permission>]
  #
  # @!method list_user_permissions(params)
  #   List user's permissions
  #   @param [BrickFTP::RESTfulAPI::ListUserPermissions::Params] params parameters
  #   @return [Array<BrickFTP::Types::Permission>]
  #
  # @!method list_group_permissions(params)
  #   List group's permissions
  #   @param [BrickFTP::RESTfulAPI::ListGroupPermissions::Params] params parameters
  #   @return [Array<BrickFTP::Types::Permission>]
  #
  # @!method create_permission(params)
  #   Create permission
  #   @param [BrickFTP::RESTfulAPI::CreatePermission::Params] params parameters
  #   @return [BrickFTP::Types::Permission]
  #
  # @!method delete_permission(params)
  #   Delete permission
  #   @param [BrickFTP::RESTfulAPI::DeletePermission::Params] params parameters
  #
  # @!method get_public_key(params)
  #  Show SSH public key
  #  @param [BrickFTP::RESTfulAPI::GetPublicKey::Params] params parameters
  #  @return [BrickFTP::Types::PublicKey]
  #
  # @!method list_public_keys(params)
  #   List user's SSH public keys
  #   @param [BrickFTP::RESTfulAPI::ListPublicKeys::Params] params parameters
  #   @return [Array<BrickFTP::Types::PublicKey>]
  #
  # @!method list_current_user_public_keys
  #   List current user's SSH public keys
  #   @return [Array<BrickFTP::Types::PublicKey>]
  #
  # @!method create_public_key(params)
  #   Create SSH public key on a user
  #   @param [BrickFTP::RESTfulAPI::CreatePublicKey::Params] params parameters
  #   @return [BrickFTP::Types::PublicKey]
  #
  # @!method create_current_user_public_key(params)
  #   Create SSH public key on current user
  #   @param [BrickFTP::RESTfulAPI::CreateCurrentUserPublicKey::Params] params parameters
  #   @return [BrickFTP::Types::PublicKey]
  #
  # @!method delete_public_key(params)
  #   Delete SSH public key
  #   @param [BrickFTP::RESTfulAPI::DeletePublicKey::Params] params parameters
  #
  # @!method list_remote_servers
  #   List remote servers
  #   @return [Array<BrickFTP::Types::RemoteServer>]
  #
  # @!method create_remote_server(params)
  #   Create remote server
  #   @param [BrickFTP::RESTfulAPI::CreateRemoteServer::Params] params parameters
  #   @return [BrickFTP::Types::RemoteServer]
  #
  # @!method update_remote_server(params)
  #   Update remote server
  #   @param [BrickFTP::RESTfulAPI::UpdateRemoteServer::Params] params parameters
  #   @return [BrickFTP::Types::RemoteServer]
  #
  # @!method delete_remote_server(params)
  #   Delete remote server
  #   @param [BrickFTP::RESTfulAPI::DeleteRemoteServer::Params] params parameters
  #
  # @!method create_session(params)
  #   Creates user session.
  #   @param [BrickFTP::RESTfulAPI::CreateSession::Params] params parameters
  #   @return [BrickFTP::Types::Session]
  #
  # @!method delete_session
  #   Delete user session (log out)
  #
  # @!method get_site_settings
  #   Show site settings
  #   @return [BrickFTP::Types::Site]
  #
  # @!method list_ip_addresses
  #   List IP addresses
  #   @return [Array<BrickFTP::Types::IpAddress>]
  #
  # @!method update_site_settings(params)
  #   Update site settings
  #   @param [BrickFTP::RESTfulAPI::UpdateSiteSettings::Params] params parameters
  #   @return [BrickFTP::Types::Site]
  #
  # @!method list_sso_strategies
  #   List SSO strategies
  #   @return [Array<BrickFTP::Types::SsoStrategy>]
  #
  # @!method create_sso_strategy(params)
  #   Create new SSO strategy
  #   @param [BrickFTP::RESTfulAPI::CreateSsoStrategy::Params] params parameters
  #   @return [BrickFTP::Types::SsoStrategy]
  #
  # @!method update_sso_strategy(params)
  #   Update SSO strategy
  #   @param [BrickFTP::RESTfulAPI::UpdateSsoStrategy::Params] params parameters
  #   @return [BrickFTP::Types::SsoStrategy]
  #
  # @!method delete_sso_strategy(params)
  #   Delete SSO strategy
  #   @param [BrickFTP::RESTfulAPI::DeleteSsoStrategy::Params] params parameters
  #
  # @!method update_style(params)
  #   Update style
  #   @param [BrickFTP::RESTfulAPI::UpdateStyle::Params] params parameters
  #   @return [BrickFTP::Types::Style]
  #
  # @!method delete_style(params)
  #   Delete style
  #   @param [BrickFTP::RESTfulAPI::DeleteStyle::Params] params parameters
  #
  # @!method list_current_user_2fa_methods
  #   List current user's 2FA methods
  #   @return [Array<BrickFTP::Types::TwoFactorAuthenticationMethod>]
  #
  # @!method create_current_user_2fa_method(params)
  #   Create 2FA method on current user
  #   @param [BrickFTP::RESTfulAPI::CreateCurrentUser2faMethod::Params] params parameters
  #   @return [BrickFTP::Types::TwoFactorAuthenticationMethod]
  #
  # @!method generate_current_user_2fa_otp(params)
  #   Generate (and send if applicable) a one time password for current user's primary 2FA method
  #   @param [BrickFTP::RESTfulAPI::GenerateCurrentUser2faOtp::Params] params parameters
  #   @return [BrickFTP::Types::TwoFactorAuthenticationOtp]
  #
  # @!method update_2fa_method(params)
  #   Update 2FA method
  #   @param [BrickFTP::RESTfulAPI::Update2faMethod::Params] params parameters
  #   @return [BrickFTP::Types::TwoFactorAuthenticationMethod]
  #
  # @!method delete_2fa_method(params)
  #   Delete 2FA method
  #   @param [BrickFTP::RESTfulAPI::Delete2faMethod::Params] params parameters
  #
  # @!method list_users(params)
  #   List users
  #   @param [BrickFTP::RESTfulAPI::ListUser::Params] params parameters
  #   @return [Array<BrickFTP::Types::User>]
  #
  # @!method get_user(params)
  #   Show user
  #   @param [BrickFTP::RESTfulAPI::GetUser::Params] params parameters
  #   @return [BrickFTP::Types::User, nil]
  #
  # @!method list_current_user_group_memberships
  #   List current user's group memberships
  #   @return [Array<BrickFTP::Types::Group>]
  #
  # @!method create_user(params)
  #   Create user
  #   @param [BrickFTP::RESTfulAPI::CreateUser::Params] params parameters
  #   @return [BrickFTP::Types::User]
  #
  # @!method resend_user_welcome_email(params)
  #   Resend user welcome email
  #   @param [BrickFTP::RESTfulAPI::ResendUserWelcomeEmail::Params] params parameters
  #   @return [BrickFTP::Types::User]
  #
  # @!method unlock_user(params)
  #   Unlock user who has been locked out due to failed logins
  #   @param [BrickFTP::RESTfulAPI::UnlockUser::Params] params parameters
  #   @return [BrickFTP::Types::User, nil]
  #
  # @!method reset_2fa(params)
  #   Trigger 2FA Reset process for user who has lost access to their existing 2FA methods
  #   @param [BrickFTP::RESTfulAPI::Reset2fa::Params] params parameters
  #
  # @!method update_user(params)
  #   Update user
  #   @param [BrickFTP::RESTfulAPI::UpdateUser::Params] params parameters
  #   @return [BrickFTP::Types::User]
  #
  # @!method update_current_user(params)
  #   Update current user
  #   @param [BrickFTP::RESTfulAPI::UpdateCurrentUser::Params] params parameters
  #   @return [BrickFTP::Types::User]
  #
  # @!method delete_user(params)
  #   Delete user
  #   @param [BrickFTP::RESTfulAPI::DeleteUser::Params] params parameters
  #
  class Client
    attr_reader :subdomain, :api_key, :api_client

    # @param [String] subdomain
    # @param [String] api_key
    def initialize(subdomain: nil, api_key: nil)
      @subdomain = subdomain || ENV['BRICK_FTP_SUBDOMAIN']
      @api_key = api_key || ENV['BRICK_FTP_API_KEY']
      @api_client = BrickFTP::RESTfulAPI::Client.new(@subdomain, @api_key)
    end

    private

    def command_class(symbol)
      name = symbol.to_s.split('_').map(&:capitalize).join
      return unless BrickFTP::RESTfulAPI.const_defined?(name)

      klass = BrickFTP::RESTfulAPI.const_get(name)
      return unless klass < BrickFTP::RESTfulAPI::Command

      klass
    end

    def respond_to_missing?(symbol, include_private)
      return true if command_class(symbol)

      super
    end

    def method_missing(name, *args)
      klass = command_class(name)
      if klass
        dispatch_command(klass, *args)
      else
        super
      end
    end

    def dispatch_command(klass, *args)
      klass.new(api_client).call(*args)
    end
  end
end
