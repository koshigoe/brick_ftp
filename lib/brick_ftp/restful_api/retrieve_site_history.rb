# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # List site actions history
    #
    # @see https://developers.files.com/#list-site-actions-history
    #
    # ### Params
    #
    # PARAMETER | TYPE     | DESCRIPTION
    # --------- | -------- | -----------
    # page      | integer  | Site actions page.
    # per_page  | integer  | Site actions to display per page.
    # start_at  | string   | Leave blank or set to a date/time to filter earlier entries.
    # end_at    | string   | Leave blank or set to a date/time to filter later entries.
    # display   | string   | Display format. Leave blank or set to full or parent.
    #
    class RetrieveSiteHistory
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'RetrieveSiteHistoryParams',
        :page,
        :per_page,
        :start_at,
        :end_at,
        :display,
        keyword_init: true
      )

      # List site actions history
      #
      # @param [BrickFTP::RESTfulAPI::RetrieveSiteHistory::Params] params parameters
      # @return [Array<BrickFTP::Types::History>]
      #
      def call(params)
        params = Params.new(params.to_h).to_h.compact
        %i[start_at end_at].each do |key|
          params[key] = params[key].utc.iso8601 if params[key].is_a?(Time)
        end

        endpoint = '/api/rest/v1/history.json'
        query = params.sort.map { |k, v| "#{k}=#{ERB::Util.url_encode(v.to_s)}" }.join('&')
        endpoint += "?#{query}" unless query.empty?
        res = client.get(endpoint)

        res.map { |i| BrickFTP::Types::History.new(i.symbolize_keys) }
      end
    end
  end
end
