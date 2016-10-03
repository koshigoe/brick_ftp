require 'spec_helper'

RSpec.describe BrickFTP::Client, type: :lib do
  describe 'Authentication' do
    describe '#login' do
      it 'delegate BrickFTP::API::Authentication.login' do
        expect(BrickFTP::API::Authentication).to receive(:login).with('koshigoe', 'password')
        described_class.new.login('koshigoe', 'password')
      end
    end

    describe '#logout' do
      it 'delegate BrickFTP::API::Authentication.logout' do
        expect(BrickFTP::API::Authentication).to receive(:logout)
        described_class.new.logout
      end
    end
  end
end
