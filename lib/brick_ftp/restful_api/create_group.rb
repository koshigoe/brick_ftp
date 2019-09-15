# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create group
    #
    # @see https://developers.files.com/#create-group Create group
    #
    class CreateGroup
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE    | DESCRIPTION
      # --------- | ------- | -----------
      # path      | string  | Required: Path
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
      # @param [BrickFTP::RESTfulAPI::CreateGroup::Params] params parameters
      # @return [BrickFTP::Types::Group]
      #
      def call(params = {})
        res = client.post('/api/rest/v1/groups.json', Params.new(params.to_h).to_h.compact)

        BrickFTP::Types::Group.new(res.symbolize_keys)
      end
    end
  end
end
