# frozen_string_literal: true

module BrickFTP
  module Commands
    # ref. https://developers.brickftp.com/#users
    autoload :ListUsers, 'brick_ftp/commands/list_users'
    autoload :CountUsers, 'brick_ftp/commands/count_users'
    autoload :SearchUser, 'brick_ftp/commands/search_user'
    autoload :GetUser, 'brick_ftp/commands/get_user'
    autoload :CreateUser, 'brick_ftp/commands/create_user'
    autoload :UpdateUser, 'brick_ftp/commands/update_user'
    autoload :DeleteUser, 'brick_ftp/commands/delete_user'
    autoload :UnlockUser, 'brick_ftp/commands/unlock_user'
    # ref. https://developers.brickftp.com/#user-api-keys
    autoload :ListAPIKeys, 'brick_ftp/commands/list_api_keys'
    autoload :GetAPIKey, 'brick_ftp/commands/get_api_key'
    autoload :CreateAPIKey, 'brick_ftp/commands/create_api_key'
    autoload :DeleteAPIKey, 'brick_ftp/commands/delete_api_key'
    # ref. https://developers.brickftp.com/#user-public-keys
    autoload :ListPublicKeys, 'brick_ftp/commands/list_public_keys'
    autoload :GetPublicKey, 'brick_ftp/commands/get_public_key'
    autoload :CreatePublicKey, 'brick_ftp/commands/create_public_key'
    autoload :DeletePublicKey, 'brick_ftp/commands/delete_public_key'
  end
end
