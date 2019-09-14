# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Update automation
    #
    # @see https://developers.files.com/#update-automation Update automation
    #
    # ### Params
    #
    # PARAMETER                | TYPE     | DESCRIPTION
    # ------------------------ | -------- | -----------
    # id                       | integer  | Required: Automation ID.
    # source                   | string   | Source Path
    # destination              | string   | Destination Path
    # destination_replace_from | string   | If set, this string in the destination path will be replaced with the value in destination_replace_to.
    # destination_replace_to   | string   | If set, this string will replace the value destination_replace_from in the destination filename. You can use special patterns here.
    # interval                 | string   | How often to run this automation? One of: day, week, week_end, month, month_end, quarter, quarter_end, year, year_end
    # path                     | string   | Path on which this Automation runs. Supports globs.
    # user_ids                 | string   | A list of user IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    # group_ids                | string   | list of group IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    #
    class UpdateAutomation
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      Params = Struct.new(
        'UpdateAutomationParams',
        :id,
        :source,
        :destination,
        :destination_replace_from,
        :destination_replace_to,
        :interval,
        :path,
        :user_ids,
        :group_ids,
        keyword_init: true
      )

      # Update automation
      #
      # @param [BrickFTP::RESTfulAPI::CreateAutomation::Params] params parameters for create an automation
      # @return [BrickFTP::Types::Automation]
      #
      def call(params)
        params = params.to_h.compact
        res = client.put("/api/rest/v1/automations/#{params.delete(:id)}.json", params)

        BrickFTP::Types::Automation.new(res.symbolize_keys)
      end
    end
  end
end
