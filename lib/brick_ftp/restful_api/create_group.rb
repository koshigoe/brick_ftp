# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    class CreateGroup
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

      # Creates a new group on the current site.
      #
      # @param [BrickFTP::RESTfulAPI::CreateGroup::Params] params parameters for creating a Group
      # @return [BrickFTP::Types::Group] created Group
      #
      def call(params)
        res = client.post('/api/rest/v1/groups.json', params.to_h.compact)

        BrickFTP::Types::Group.new(res.symbolize_keys)
      end
    end
  end
end
