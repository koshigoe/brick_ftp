# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Update group
    #
    # @see https://developers.files.com/#update-group Update group
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Required: Group ID.
    # name      | string  | Group name.
    # notes     | string  | Group notes.
    # user_ids  | string  | A list of user ids. If sent as a string, should be comma-delimited.
    # admin_ids | string  | A list of group admin user ids. If sent as a string, should be comma-delimited.
    #
    class UpdateGroup
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'UpdateGroupParams',
        :id,
        :name,
        :notes,
        :user_ids,
        :admin_ids,
        keyword_init: true
      )

      # Update group
      #
      # @param [BrickFTP::RESTfulAPI::UpdateGroup::Params] params parameters for updating a Group
      # @return [BrickFTP::Types::Group]
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        res = client.put("/api/rest/v1/groups/#{params.delete(:id)}.json", params)

        BrickFTP::Types::Group.new(res.symbolize_keys)
      end
    end
  end
end
