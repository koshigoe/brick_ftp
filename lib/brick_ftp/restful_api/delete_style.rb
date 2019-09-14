# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Delete style
    #
    # @see https://developers.files.com/#delete-style Delete style
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # path      | string  | Required: Style path.
    #
    class DeleteStyle
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'DeleteStyleParams',
        :path,
        keyword_init: true
      )

      # Delete style
      #
      # @param [BrickFTP::RESTfulAPI::DeleteStyle::Params] params parameters
      #
      def call(params)
        params = params.to_h.compact
        client.delete("/api/rest/v1/styles/#{ERB::Util.url_encode(params.delete(:path))}")
        true
      end
    end
  end
end
