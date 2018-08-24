# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # List behaviors for a folder
    #
    # @see https://developers.brickftp.com/#list-behaviors-for-a-folder List behaviors for a folder
    #
    # ### Params
    #
    # PARAMETER | TYPE     | DESCRIPTION
    # --------- | -------- | -----------
    # recursive | integer  | Optionally set to 1 to have response include behaviors inherited from parent folders.
    #
    class ListFolderBehaviors
      include Command

      # Returns the behaviors that apply to the given path.
      #
      # By default, only behaviors applied directly on the the given path will be returned.
      # If you would also like behaviors that are inherited from parent folders to be returned,
      # the recursive query parameter can be passed in on the URL with the value of 1.
      #
      # @param [String] path
      # @param [Boolean] recursive
      # @return [Array<BrickFTP::Types::Behavior>] Behaviors
      #
      def call(path, recursive: false)
        endpoint = "/api/rest/v1/behaviors/folders/#{ERB::Util.url_encode(path)}"
        endpoint = "#{endpoint}?recursive=1" if recursive
        res = client.get(endpoint)

        res.map { |i| BrickFTP::Types::Behavior.new(i.symbolize_keys) }
      end
    end
  end
end
