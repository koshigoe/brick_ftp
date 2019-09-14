# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create group
    #
    # @see https://developers.files.com/#create-group Create group
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # name      | string  | Group name.
    # notes     | string  | Group notes.
    # user_ids  | string  | A list of user ids. If sent as a string, should be comma-delimited.
    # admin_ids | string  | A list of group admin user ids. If sent as a string, should be comma-delimited.
    #
    class CreateGroup
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'CreateGroupParams',
        :name,
        :notes,
        :user_ids,
        :admin_ids,
        keyword_init: true
      )

      # Create group
      #
      # @param [BrickFTP::RESTfulAPI::CreateGroup::Params] params parameters for creating a Group
      # @return [BrickFTP::Types::Group]
      #
      def call(params = {})
        res = client.post('/api/rest/v1/groups.json', Params.new(params.to_h).to_h.compact)

        BrickFTP::Types::Group.new(res.symbolize_keys)
      end
    end
  end
end
