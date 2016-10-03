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

  describe 'User' do
    describe '#list_users' do
      it 'delegate BrickFTP::API::User.all' do
        expect(BrickFTP::API::User).to receive(:all)
        described_class.new.list_users
      end
    end

    describe '#show_user' do
      let(:id) { 1 }
      it 'delegate BrickFTP::API::User.find' do
        expect(BrickFTP::API::User).to receive(:find).with(id)
        described_class.new.show_user(id)
      end
    end

    describe '#create_user' do
      let(:attributes) { {} }
      it 'delegate BrickFTP::API::User.create' do
        expect(BrickFTP::API::User).to receive(:create).with(attributes)
        described_class.new.create_user(attributes)
      end
    end

    describe '#update_user' do
      let(:user) { BrickFTP::API::User.new(id: 1) }
      let(:attributes) { {} }
      it 'delegate BrickFTP::API::User#update' do
        expect(user).to receive(:update).with(attributes)
        described_class.new.update_user(user, attributes)
      end
    end

    describe '#delete_user' do
      let(:user) { BrickFTP::API::User.new(id: 1) }
      it 'delegate BrickFTP::API::User#destroy' do
        expect(user).to receive(:destroy)
        described_class.new.delete_user(user)
      end
    end
  end
end
