# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Show user
    #
    # @see https://developers.files.com/#show-user Show user
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # id        | integer | Required: User ID.
    #
    class GetUser
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'GetUserParams',
        :id,
        keyword_init: true
      )

      # Show user
      #
      # @param [BrickFTP::RESTfulAPI::GetUser::Params] params parameters
      # @return [BrickFTP::Types::User, nil]
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        res = client.get("/api/rest/v1/users/#{params.delete(:id)}.json")
        return nil if !res || res.empty?

        BrickFTP::Types::User.new(res.symbolize_keys)
      end
    end
  end
end
