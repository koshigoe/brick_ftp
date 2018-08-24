# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create a group
    #
    # @see https://developers.brickftp.com/#create-a-group Create a group
    #
    # ### Params
    #
    # PARAMETER | TYPE                     | DESCRIPTION
    # --------- | ------------------------ | -----------
    # name      | string                   | Name of the group. This is how the group will be displayed on the site. Maximum of 50 characters.
    # notes     | text                     | You may use this property to store any additional information you require. There are no restrictions on its formatting.
    # user_ids  | comma-separated integers | IDs of the users that are in this group.
    #
    class CreateGroup
      include Command

      Params = Struct.new(
        'CreateGroupParams',
        :name,
        :notes,
        :user_ids,
        keyword_init: true
      )

      # Creates a new group on the current site.
      #
      # @param [BrickFTP::RESTfulAPI::CreateGroup::Params] params parameters for creating a Group
      # @return [BrickFTP::Types::Group] created Group
      #
      def call(params)
        res = client.post('/api/rest/v1/groups.json', params.to_h.compact)

        BrickFTP::Types::Group.new(res.symbolize_keys)
      end
    end
  end
end
