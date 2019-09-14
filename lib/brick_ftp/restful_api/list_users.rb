# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # List users
    #
    # @see https://developers.files.com/#list-users List users
    #
    # ### Params
    #
    # PARAMETER                 | TYPE    | DESCRIPTION
    # ------------------------- | ------- | -----------
    # ids                       | string  | Comma-separated list of user ids to include in results.
    # page                      | integer | Current page.
    # per_page                  | integer | Users per page.
    # q[username]               | string  | List users matching username.
    # q[email]                  | string  | List users matching email.
    # q[notes]                  | string  | List users matching notes field.
    # q[admin]                  | string  | If true, list only admin users.
    # q[allowed_ips]            | string  | If set, list only users with overridden allowed IP setting.
    # q[password_validity_days] | string  | If set, list only users with overridden password validity days setting.
    # q[ssl_required]           | string  | If set, list only users with overridden SSL required setting.
    # search                    | string  | Searches for partial matches of name, username, or email.
    # action                    | string  | If set to 'count' returns the current site user count.
    #
    class ListUsers
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'ListUserParams',
        :ids,
        :page,
        :per_page,
        :q,
        :search,
        :action,
        keyword_init: true
      )

      Q = Struct.new(
        'ListUserParamQ',
        :username,
        :email,
        :notes,
        :admin,
        :allowed_ips,
        :password_validity_days,
        :ssl_required,
        keyword_init: true
      )

      # List users
      #
      # @param [BrickFTP::RESTfulAPI::ListUser::Params] params parameters
      # @return [Array<BrickFTP::Types::User>]
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        q = params.delete(:q)
        params.update(q.to_h.compact.each_with_object({}) { |(k, v), m| m[:"q[#{k}]"] = v }) if q

        query = params.sort.map { |k, v| "#{ERB::Util.url_encode(k.to_s)}=#{ERB::Util.url_encode(v.to_s)}" }.join('&')
        endpoint = '/api/rest/v1/users.json'
        endpoint = "#{endpoint}?#{query}" unless query.empty?
        res = client.get(endpoint)

        res.map { |i| BrickFTP::Types::User.new(i.symbolize_keys) }
      end
    end
  end
end
