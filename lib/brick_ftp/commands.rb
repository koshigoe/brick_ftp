# frozen_string_literal: true

module BrickFTP
  module Commands
    autoload :ListUsers, 'brick_ftp/commands/list_users'
    autoload :CountUsers, 'brick_ftp/commands/count_users'
    autoload :SearchUser, 'brick_ftp/commands/search_user'
    autoload :GetUser, 'brick_ftp/commands/get_user'
    autoload :CreateUser, 'brick_ftp/commands/create_user'
  end
end
