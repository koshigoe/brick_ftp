# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create behavior
    #
    # @see https://developers.files.com/#create-behavior Create behavior
    #
    # ### Params
    #
    # PARAMETER | TYPE   | DESCRIPTION
    # --------- | ------ | -----------
    # path      | string | Required: Folder behaviors path.
    # behavior  | string | Required: Behavior type.
    # value     | string | The value of the folder behavior. Can be a integer, array, or hash depending on the type of folder behavior.
    #
    class CreateBehavior
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'CreateBehaviorParams',
        :path,
        :behavior,
        :value,
        keyword_init: true
      )

      # Create behavior
      #
      # @param [BrickFTP::RESTfulAPI::CreateBehavior::Params] params parameters
      # @return [BrickFTP::Types::Behavior] Behavior
      #
      def call(params)
        res = client.post('/api/rest/v1/behaviors.json', Params.new(params.to_h).to_h.compact)

        BrickFTP::Types::Behavior.new(res.symbolize_keys)
      end
    end
  end
end
