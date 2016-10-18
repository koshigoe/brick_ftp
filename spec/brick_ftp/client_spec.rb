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

  describe 'Group' do
    describe '#list_groups' do
      it 'delegate BrickFTP::API::Group.all' do
        expect(BrickFTP::API::Group).to receive(:all)
        described_class.new.list_groups
      end
    end

    describe '#show_group' do
      let(:id) { 1 }
      it 'delegate BrickFTP::API::Group.find' do
        expect(BrickFTP::API::Group).to receive(:find).with(id)
        described_class.new.show_group(id)
      end
    end

    describe '#create_group' do
      let(:attributes) { {} }
      it 'delegate BrickFTP::API::Group.create' do
        expect(BrickFTP::API::Group).to receive(:create).with(attributes)
        described_class.new.create_group(attributes)
      end
    end

    describe '#update_group' do
      let(:group) { BrickFTP::API::Group.new(id: 1) }
      let(:attributes) { {} }
      it 'delegate BrickFTP::API::Group#update' do
        expect(group).to receive(:update).with(attributes)
        described_class.new.update_group(group, attributes)
      end
    end

    describe '#delete_group' do
      let(:group) { BrickFTP::API::Group.new(id: 1) }
      it 'delegate BrickFTP::API::Group#destroy' do
        expect(group).to receive(:destroy)
        described_class.new.delete_group(group)
      end
    end
  end

  describe 'Permission' do
    describe '#list_permissions' do
      it 'delegate BrickFTP::API::Permission.all' do
        expect(BrickFTP::API::Permission).to receive(:all)
        described_class.new.list_permissions
      end
    end

    describe '#create_permission' do
      let(:attributes) { {} }
      it 'delegate BrickFTP::API::Permission.create' do
        expect(BrickFTP::API::Permission).to receive(:create).with(attributes)
        described_class.new.create_permission(attributes)
      end
    end

    describe '#delete_permission' do
      let(:permission) { BrickFTP::API::Permission.new(id: 1) }
      it 'delegate BrickFTP::API::Permission#destroy' do
        expect(permission).to receive(:destroy)
        described_class.new.delete_permission(permission)
      end
    end
  end

  describe 'Notification' do
    describe '#list_notifications' do
      it 'delegate BrickFTP::API::Notification.all' do
        expect(BrickFTP::API::Notification).to receive(:all)
        described_class.new.list_notifications
      end
    end

    describe '#create_notification' do
      let(:attributes) { {} }
      it 'delegate BrickFTP::API::Notification.create' do
        expect(BrickFTP::API::Notification).to receive(:create).with(attributes)
        described_class.new.create_notification(attributes)
      end
    end

    describe '#delete_notification' do
      let(:notification) { BrickFTP::API::Notification.new(id: 1) }
      it 'delegate BrickFTP::API::Notification#destroy' do
        expect(notification).to receive(:destroy)
        described_class.new.delete_notification(notification)
      end
    end
  end

  describe 'History' do
    let(:query) { { page: 1, per_page: 1, start_at: '2015-09-30T18:58:16-04:00' } }

    describe '#list_site_history' do
      it 'delegate BrickFTP::API::History::Site.all' do
        expect(BrickFTP::API::History::Site).to receive(:all).with(query)
        described_class.new.list_site_history(query)
      end
    end

    describe '#list_login_history' do
      it 'delegate BrickFTP::API::History::Login.all' do
        expect(BrickFTP::API::History::Login).to receive(:all).with(query)
        described_class.new.list_login_history(query)
      end
    end

    describe '#list_user_history' do
      it 'delegate BrickFTP::API::History::User.all' do
        query.update(user_id: 1)
        expect(BrickFTP::API::History::User).to receive(:all).with(query)
        described_class.new.list_user_history(query)
      end
    end

    describe '#list_folder_history' do
      before { query.update(path: 'a/b') }
      it 'delegate BrickFTP::API::History::Folder.all' do
        expect(BrickFTP::API::History::Folder).to receive(:all).with(query)
        described_class.new.list_folder_history(query)
      end
    end

    describe '#list_file_history' do
      before { query.update(path: 'a/b/c.txt') }
      it 'delegate BrickFTP::API::History::File.all' do
        expect(BrickFTP::API::History::File).to receive(:all).with(query)
        described_class.new.list_file_history(query)
      end
    end
  end

  describe 'Bundle' do
    describe '#list_bundles' do
      it 'delegate BrickFTP::API::Bundle.all' do
        expect(BrickFTP::API::Bundle).to receive(:all)
        described_class.new.list_bundles
      end
    end

    describe '#show_bundle' do
      let(:id) { 1 }
      it 'delegate BrickFTP::API::Bundle.find' do
        expect(BrickFTP::API::Bundle).to receive(:find).with(id)
        described_class.new.show_bundle(id)
      end
    end

    describe '#create_bundle' do
      let(:attributes) { {} }
      it 'delegate BrickFTP::API::Bundle.create' do
        expect(BrickFTP::API::Bundle).to receive(:create).with(attributes)
        described_class.new.create_bundle(attributes)
      end
    end

    describe '#delete_bundle' do
      let(:bundle) { BrickFTP::API::Bundle.new(id: 1) }
      it 'delegate BrickFTP::API::Bundle#destroy' do
        expect(bundle).to receive(:destroy)
        described_class.new.delete_bundle(bundle)
      end
    end

    describe '#list_bundle_contents' do
      let(:query) { { path: 'a/b', code: 'a0b1c2d3e', host: 'justin.brickftp.com' } }
      it 'delegate BrickFTP::API::BundleContent.all' do
        expect(BrickFTP::API::BundleContent).to receive(:all).with(query)
        described_class.new.list_bundle_contents(query)
      end
    end

    describe '#list_bundle_downloads' do
      let(:query) { { code: 'a0b1c2d3e', host: 'justin.brickftp.com', paths: %w(cloud/images/image1.jpg backup.zip) } }
      it 'delegate BrickFTP::API::BundleDownload.all' do
        expect(BrickFTP::API::BundleDownload).to receive(:all).with(query)
        described_class.new.list_bundle_downloads(query)
      end
    end
  end

  describe 'Behavior' do
    describe '#list_behaviors' do
      it 'delegate BrickFTP::API::Behavior.all' do
        expect(BrickFTP::API::Behavior).to receive(:all)
        described_class.new.list_behaviors
      end
    end

    describe '#show_behavior' do
      let(:id) { 1 }
      it 'delegate BrickFTP::API::Behavior.find' do
        expect(BrickFTP::API::Behavior).to receive(:find).with(id)
        described_class.new.show_behavior(id)
      end
    end

    describe '#create_behavior' do
      let(:attributes) { {} }
      it 'delegate BrickFTP::API::Behavior.create' do
        expect(BrickFTP::API::Behavior).to receive(:create).with(attributes)
        described_class.new.create_behavior(attributes)
      end
    end

    describe '#update_behavior' do
      let(:behavior) { BrickFTP::API::Behavior.new(id: 1) }
      let(:attributes) { {} }
      it 'delegate BrickFTP::API::Behavior#update' do
        expect(behavior).to receive(:update).with(attributes)
        described_class.new.update_behavior(behavior, attributes)
      end
    end

    describe '#delete_behavior' do
      let(:behavior) { BrickFTP::API::Behavior.new(id: 1) }
      it 'delegate BrickFTP::API::Behavior#destroy' do
        expect(behavior).to receive(:destroy)
        described_class.new.delete_behavior(behavior)
      end
    end

    describe '#list_folder_behaviors' do
      it 'delegate BrickFTP::API::FolderBehavior.all' do
        expect(BrickFTP::API::FolderBehavior).to receive(:all).with(path: 'a/b')
        described_class.new.list_folder_behaviors(path: 'a/b')
      end
    end
  end

  describe 'Folder' do
    describe '#list_folders' do
      let(:query) do
        {
          path: 'a/b',
          page: 1,
          per_page: 1,
          search: 'a/b',
          sort_by_path: 'asc',
          sort_by_size: 'asc',
          sort_by_modified_at_datetime: 'asc',
        }
      end

      it 'delegate BrickFTP::API::Folder.all' do
        converted_query = {
          path: 'a/b',
          page: 1,
          per_page: 1,
          search: 'a/b',
          :'sort_by[path]' => 'asc',
          :'sort_by[size]' => 'asc',
          :'sort_by[modified_at_datetime]' => 'asc',
        }
        expect(BrickFTP::API::Folder).to receive(:all).with(converted_query)
        described_class.new.list_folders(query)
      end
    end

    describe '#create_folder' do
      it 'delegate BrickFTP::API::Folder.create' do
        expect(BrickFTP::API::Folder).to receive(:create).with(path: 'a/b')
        described_class.new.create_folder(path: 'a/b')
      end
    end
  end

  describe 'File' do
    describe '#show_file' do
      it 'delegate BrickFTP::API::File.find' do
        expect(BrickFTP::API::File).to receive(:find).with('a/b')
        described_class.new.show_file('a/b')
      end
    end

    describe '#move_file' do
      it 'delegate BrickFTP::API::FileOperation::Move.create' do
        expect(BrickFTP::API::FileOperation::Move).to receive(:create).with(path: 'a/b', :'move-destination' => 'a/B')
        described_class.new.move_file(path: 'a/b', move_destination: 'a/B')
      end
    end

    describe '#copy_file' do
      it 'delegate BrickFTP::API::FileOperation::Copy.create' do
        expect(BrickFTP::API::FileOperation::Copy).to receive(:create).with(path: 'a/b', :'copy-destination' => 'a/B')
        described_class.new.copy_file(path: 'a/b', copy_destination: 'a/B')
      end
    end

    describe '#delete_file' do
      let(:file) { BrickFTP::API::File.new(id: 'a/b') }

      context 'without options' do
        it 'delegate BrickFTP::API::File#destroy' do
          expect(file).to receive(:destroy).with(recursive: false)
          described_class.new.delete_file(file)
        end
      end

      context 'recursive: true' do
        it 'delegate BrickFTP::API::File#destroy' do
          expect(file).to receive(:destroy).with(recursive: true)
          described_class.new.delete_file(file, recursive: true)
        end
      end
    end

    describe '#upload_file' do
      it 'delegate BrickFTP::API::FileOperation::Upload.create' do
        expect(BrickFTP::API::FileOperation::Upload).to receive(:create).with(path: 'a/b', source: 'b')
        described_class.new.upload_file(path: 'a/b', source: 'b')
      end
    end
  end
end
