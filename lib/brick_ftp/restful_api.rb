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
  end
end
