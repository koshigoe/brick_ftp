# frozen_string_literal: true

module BrickFTP
  module Types
    User = Struct.new(
      'User',
      :id,
      :username,
      :authentication_method,
      :last_login_at,
      :authenticate_until,
      :name,
      :email,
      :notes,
      :group_ids,
      :ftp_permission,
      :sftp_permission,
      :dav_permission,
      :restapi_permission,
      :attachments_permission,
      :self_managed,
      :require_password_change,
      :require_2fa,
      :allowed_ips,
      :user_root,
      :time_zone,
      :language,
      :ssl_required,
      :site_admin,
      :password_set_at,
      :receive_admin_alerts,
      :subscribe_to_newsletter,
      :last_protocol_cipher,
      :lockout_expires,
      :admin_group_ids,
      keyword_init: true
    )
  end
end
