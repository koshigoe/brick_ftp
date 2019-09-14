# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::GetSiteSettings, type: :lib do
  describe '#call' do
    it 'return Site object' do
      expected_site = BrickFTP::Types::Site.new(
        allowed_2fa_method_sms: true,
        allowed_2fa_method_totp: true,
        allowed_2fa_method_u2f: true,
        allowed_2fa_method_yubi: true,
        admin_user_id: 1,
        allowed_file_types: '',
        allowed_ips: '',
        ask_about_overwrites: true,
        bundle_expiration: 1,
        bundle_password_required: true,
        color2_left: '#0066a7',
        color2_link: '#d34f5d',
        color2_text: '#0066a7',
        color2_top: '#000000',
        color2_top_text: '#ffffff',
        created_at: '2000-01-01 01:00:00 UTC',
        currency: 'USD',
        custom_namespace: true,
        days_to_retain_backups: 30,
        default_time_zone: 'Pacific Time (US & Canada)',
        desktop_app: true,
        desktop_app_session_ip_pinning: true,
        desktop_app_session_lifetime: 1,
        disable_notifications: true,
        disable_password_reset: true,
        domain: 'my-custom-domain.com',
        email: 'john.doe@files.com',
        hipaa: true,
        icon128: '',
        icon16: '',
        icon32: '',
        icon48: '',
        immutable_files_set_at: '2000-01-01 01:00:00 UTC',
        include_password_in_welcome_email: true,
        language: 'en',
        ldap_base_dn: '',
        ldap_domain: 'mysite.com',
        ldap_enabled: true,
        ldap_group_action: 'disabled',
        ldap_group_exclusion: '',
        ldap_group_inclusion: '',
        ldap_host: 'ldap.site.com',
        ldap_host_2: 'ldap2.site.com',
        ldap_host_3: 'ldap3.site.com',
        ldap_port: 1,
        ldap_secure: true,
        ldap_type: 'open_ldap',
        ldap_user_action: 'disabled',
        ldap_user_include_groups: '',
        ldap_username: '[ldap username]',
        ldap_username_field: 'sAMAccountName',
        login_help_text: 'Login page help text.',
        logo: '',
        max_prior_passwords: 1,
        name: 'My Site',
        next_billing_amount: '',
        next_billing_date: 'Apr 20',
        opt_out_global: true,
        overage_notified_at: '2000-01-01 01:00:00 UTC',
        overage_notify: true,
        overdue: true,
        password_min_length: 1,
        password_require_letter: true,
        password_require_mixed: true,
        password_require_number: true,
        password_require_special: true,
        password_validity_days: 1,
        phone: '555-555-5555',
        require_2fa: true,
        require_2fa_stop_time: '2000-01-01 01:00:00 UTC',
        session: '',
        session_pinned_by_ip: true,
        sftp_user_root_enabled: true,
        show_request_access_link: true,
        site_footer: '',
        site_header: '',
        smtp_address: 'smtp.my-mail-server.com',
        smtp_authentication: 'plain',
        smtp_from: 'me@my-mail-server.com',
        smtp_port: 25,
        smtp_username: 'mail',
        session_expiry: 6,
        ssl_required: true,
        subdomain: 'mysite',
        switch_to_plan_date: '2000-01-01 01:00:00 UTC',
        tls_disabled: true,
        trial_days_left: 1,
        trial_until: '2000-01-01 01:00:00 UTC',
        updated_at: '2000-01-01 01:00:00 UTC',
        use_provided_modified_at: true,
        user: '',
        user_lockout: true,
        user_lockout_lock_period: 1,
        user_lockout_tries: 1,
        user_lockout_within: 6,
        welcome_custom_text: 'Welcome to my site!',
        welcome_email_cc: '',
        welcome_email_enabled: true,
        windows_mode_ftp: true
      )

      stub_request(:get, 'https://subdomain.files.com/api/rest/v1/site.json')
        .with(
          basic_auth: %w[api-key x],
          headers: {
            'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
          }
        )
        .to_return(body: expected_site.to_h.to_json)

      rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
      command = BrickFTP::RESTfulAPI::GetSiteSettings.new(rest)

      expect(command.call).to eq expected_site
    end
  end
end
