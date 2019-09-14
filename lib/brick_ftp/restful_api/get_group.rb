# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Show group
    #
    # @see https://developers.files.com/#show-group Show group
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Required: Group ID.
    #
    class GetGroup
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'GetGroupParams',
        :id,
        keyword_init: true
      )

      # Show group
      #
      # @param [BrickFTP::RESTfulAPI::GetGroup::Params] params parameters
      # @return [BrickFTP::Types::Group, nil]
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        res = client.get("/api/rest/v1/groups/#{params.delete(:id)}.json")
        return nil if !res || res.empty?

        BrickFTP::Types::Group.new(res.symbolize_keys)
      end
    end
  end
end
