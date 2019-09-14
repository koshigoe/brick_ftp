# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # ## The IP Address object
    #
    # @see https://developers.files.com/#list-ip-addresses IP addresses
    #
    # ATTRIBUTE       | TYPE    | DESCRIPTION
    # --------------- | ------- | -----------
    # associated_with | string  |
    # group_id        | integer |
    # ip_addresses    | array   |
    #
    IpAddress = Struct.new(
      'IpAddress',
      :associated_with,
      :group_id,
      :ip_addresses,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
