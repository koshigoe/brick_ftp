# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    autoload :Client, 'brick_ftp/restful_api/client'
    autoload :Command, 'brick_ftp/restful_api/command'
    # ref. https://developers.brickftp.com/#users
    autoload :ListUsers, 'brick_ftp/restful_api/list_users'
    autoload :CountUsers, 'brick_ftp/restful_api/count_users'
    autoload :SearchUser, 'brick_ftp/restful_api/search_user'
    autoload :GetUser, 'brick_ftp/restful_api/get_user'
    autoload :CreateUser, 'brick_ftp/restful_api/create_user'
    autoload :UpdateUser, 'brick_ftp/restful_api/update_user'
    autoload :DeleteUser, 'brick_ftp/restful_api/delete_user'
    autoload :UnlockUser, 'brick_ftp/restful_api/unlock_user'
    # ref. https://developers.brickftp.com/#user-api-keys
    autoload :ListAPIKeys, 'brick_ftp/restful_api/list_api_keys'
    autoload :GetAPIKey, 'brick_ftp/restful_api/get_api_key'
    autoload :CreateAPIKey, 'brick_ftp/restful_api/create_api_key'
    autoload :DeleteAPIKey, 'brick_ftp/restful_api/delete_api_key'
    # ref. https://developers.brickftp.com/#user-public-keys
    autoload :ListPublicKeys, 'brick_ftp/restful_api/list_public_keys'
    autoload :GetPublicKey, 'brick_ftp/restful_api/get_public_key'
    autoload :CreatePublicKey, 'brick_ftp/restful_api/create_public_key'
    autoload :DeletePublicKey, 'brick_ftp/restful_api/delete_public_key'
    # ref. https://developers.brickftp.com/#groups
    autoload :ListGroups, 'brick_ftp/restful_api/list_groups'
    autoload :GetGroup, 'brick_ftp/restful_api/get_group'
    autoload :CreateGroup, 'brick_ftp/restful_api/create_group'
    autoload :UpdateGroup, 'brick_ftp/restful_api/update_group'
    autoload :DeleteGroup, 'brick_ftp/restful_api/delete_group'
    autoload :CreateUserInGroup, 'brick_ftp/restful_api/create_user_in_group'
    autoload :AddGroupMember, 'brick_ftp/restful_api/add_group_member'
    autoload :UpdateGroupMember, 'brick_ftp/restful_api/update_group_member'
    autoload :RemoveGroupMember, 'brick_ftp/restful_api/remove_group_member'
    # ref. https://developers.brickftp.com/#permissions
    autoload :ListPermissions, 'brick_ftp/restful_api/list_permissions'
    autoload :CreatePermission, 'brick_ftp/restful_api/create_permission'
    autoload :DeletePermission, 'brick_ftp/restful_api/delete_permission'
    # ref. https://developers.brickftp.com/#notifications
    autoload :ListNotifications, 'brick_ftp/restful_api/list_notifications'
    autoload :CreateNotification, 'brick_ftp/restful_api/create_notification'
    autoload :DeleteNotification, 'brick_ftp/restful_api/delete_notification'
    # ref. https://developers.brickftp.com/#history
    autoload :RetrieveHistory, 'brick_ftp/restful_api/retrieve_history'
    autoload :RetrieveSiteHistory, 'brick_ftp/restful_api/retrieve_site_history'
    autoload :RetrieveLoginHistory, 'brick_ftp/restful_api/retrieve_login_history'
  end
end
