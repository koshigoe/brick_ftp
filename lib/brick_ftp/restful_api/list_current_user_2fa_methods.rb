# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # List current user's 2FA methods
    #
    # @see https://developers.files.com/#list-current-user-39-s-2fa-methods List current user's 2FA methods
    #
    class ListCurrentUser2faMethods
      include Command
      using BrickFTP::CoreExt::Hash

      # List current user's 2FA methods
      #
      # @return [Array<BrickFTP::Types::TwoFactorAuthenticationMethod>]
      #
      def call
        res = client.get('/api/rest/v1/2fa.json')

        res.map { |i| BrickFTP::Types::TwoFactorAuthenticationMethod.new(i.symbolize_keys) }
      end
    end
  end
end
