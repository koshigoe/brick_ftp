# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # Update style
    #
    # @see https://developers.files.com/#update-style Update style
    #
    # ### Params
    #
    # PARAMETER | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # path      | string  | Required: Style path.
    # file      | file    | Required: Logo for custom branding.
    #
    class UpdateStyle
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'UpdateStyleParams',
        :path,
        :file,
        keyword_init: true
      )

      # Update style
      #
      # @param [BrickFTP::RESTfulAPI::UpdateStyle::Params] params parameters
      # @return [BrickFTP::Types::Style]
      #
      def call(params = {})
        params = Params.new(params.to_h).to_h.compact
        res = client.put("/api/rest/v1/styles/#{ERB::Util.url_encode(params.delete(:path))}", params)

        BrickFTP::Types::Style.new(res.symbolize_keys)
      end
    end
  end
end
