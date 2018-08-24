# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create a user in a group
    #
    # @see https://developers.brickftp.com/#create-a-user-in-a-groupCreate a user in a group
    #
    # ### Params
    #
    # PARAMETER               | TYPE                     | DESCRIPTION
    # ----------------------- | ------------------------ | -----------
    # username                | string                   | Username for the user. This is how the user will be displayed on the site. Maximum of 50 characters.
    # password                | string                   | Password for the user. This property is write-only. It cannot be retrieved via the API.
    # authenticate_until      | datetime                 | If set, the user will be blocked from logging in after this date.
    # name                    | string                   | Real name of the user. For your reference. Maximum of 50 characters.
    # email                   | string                   | E-Mail address of the user. Maximum of 50 characters.
    # notes                   | text                     | You may use this property to store any additional information you require. There are no restrictions on its formatting.
    # group_ids               | comma-separated integers | IDs of the Groups that this user is in.
    # require_password_change | boolean                  | Require user to change their password at their next login. Note: requires restapi_permission to be true, as password changes can only occur via the web interface. Default is false.
    # user_root               | string                   | Folder to show as the root when this user logs in via the FTP interface. Make sure this folder exists, as it will not be automatically created. Does not apply to the web interface! This should not contain a leading slash, but must contain a trailing slash. Example: Users/jenny/. Limit of 250 characters.
    # time_zone               | string                   | File modification times will be displayed in this time zone. Default is Eastern Time (US & Canada).
    # language                | string                   | The language that BrickFTP will be displayed in, if the translation is available. Leave as default (null) to auto-detect or use the site setting.
    #
    class CreateUserInGroup
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'CreateUserInGroupParams',
        :username,
        :password,
        :authenticate_until,
        :name,
        :email,
        :notes,
        :group_ids,
        :require_password_change,
        :user_root,
        :time_zone,
        :language,
        keyword_init: true
      )

      # Creates a new user within a specified group.
      #
      # @param [Integer] id Globally unique identifier of each group.
      #   Each group is given an ID automatically upon creation.
      # @param [BrickFTP::RESTfulAPI::CreateUserInGroup::Params] params parameters
      # @return [BrickFTP::Types::User] created User
      #
      def call(id, params)
        res = client.post("/api/rest/v1/groups/#{id}/users.json", user: params.to_h.compact)

        BrickFTP::Types::User.new(res.symbolize_keys)
      end
    end
  end
end
