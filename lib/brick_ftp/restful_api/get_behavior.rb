# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Show behavior
    #
    # @see https://developers.files.com/#show-behavior Show behavior
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Required: Folder behavior ID.
    #
    class GetBehavior
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'GetBehaviorParams',
        :id,
        keyword_init: true
      )

      # Show behavior
      #
      # @param [BrickFTP::RESTfulAPI::GetBehavior::Params] params parameters
      # @return [BrickFTP::Types::Behavior, nil] found Behavior or nil
      #
      def call(params)
        params = Params.new(params.to_h).to_h.compact
        res = client.get("/api/rest/v1/behaviors/#{params.delete(:id)}.json")
        return nil if !res || res.empty?

        BrickFTP::Types::Behavior.new(res.symbolize_keys)
      end
    end
  end
end
