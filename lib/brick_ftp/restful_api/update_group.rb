# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    class UpdateGroup
      include Command

      # rubocop:disable Metrics/LineLength
      Params = Struct.new(
        'CreateGroupParams',
        :name,     # string                   | Name of the group. This is how the group will be displayed on the site. Maximum of 50 characters.
        :notes,    # text                     | You may use this property to store any additional information you require. There are no restrictions on its formatting.
        :user_ids, # comma-separated integers | IDs of the users that are in this group.
        keyword_init: true
      )
      # rubocop:enable Metrics/LineLength

      # Updates the specified group.
      #
      # @param [Integer] id Globally unique identifier of each group.
      #   Each group is given an ID automatically upon creation.
      # @param [BrickFTP::RESTfulAPI::UpdateGroup::Params] params parameters for updating a Group
      # @return [BrickFTP::Types::Group] updated Group
      #
      def call(id, params)
        res = client.put("/api/rest/v1/groups/#{id}.json", params.to_h.compact)

        BrickFTP::Types::Group.new(res.symbolize_keys)
      end
    end
  end
end
