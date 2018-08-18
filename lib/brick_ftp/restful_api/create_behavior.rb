# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    class CreateBehavior
      include Command

      # rubocop:disable Metrics/LineLength
      Params = Struct.new(
        'CreateBehaviorParams',
        :path,     # string  | Folder path for behaviors. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
        :behavior, # string  | The behavior type. Can be one of the following: webhook, file_expiration, auto_encrypt, lock_subfolders.
        :value,    # array   | Array of values associated with the behavior.
        keyword_init: true
      )
      # rubocop:enable Metrics/LineLength

      # Creates a new behavior.
      #
      # @param [BrickFTP::RESTfulAPI::CreateBehavior::Params] params parameters
      # @return [BrickFTP::Types::Behavior] Behavior
      #
      def call(params)
        res = client.post('/api/rest/v1/behaviors.json', params.to_h.compact)

        BrickFTP::Types::Behavior.new(res.symbolize_keys)
      end
    end
  end
end
