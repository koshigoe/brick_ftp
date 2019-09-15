# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete user
    #
    # @see https://developers.files.com/#delete-user Delete user
    #
    class DeleteUser
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER | TYPE    | DESCRIPTION
      # --------- | ------- | -----------
      # id        | integer | User ID.
      Params = Struct.new(
        'DeleteUserParams',
        :id,
        keyword_init: true
      )

      # Delete user
      #
      # @param [BrickFTP::RESTfulAPI::DeleteUser::Params] params parameters
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        client.delete("/api/rest/v1/users/#{params[:id]}.json")
        true
      end
    end
  end
end
