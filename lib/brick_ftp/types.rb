# frozen_string_literal: true

module BrickFTP
  module Types
    autoload :User, 'brick_ftp/types/user'
    autoload :UserAPIKey, 'brick_ftp/types/user_api_key'
    autoload :UserPublicKey, 'brick_ftp/types/user_public_key'
    autoload :Group, 'brick_ftp/types/group'
    autoload :GroupMembership, 'brick_ftp/types/group_membership'
    autoload :Permission, 'brick_ftp/types/permission'
  end
end
