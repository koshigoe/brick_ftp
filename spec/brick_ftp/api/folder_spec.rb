require 'spec_helper'

RSpec.describe BrickFTP::API::Folder, type: :lib do
  before { BrickFTP.config.api_key = 'xxxxxxxx' }

  describe '.all' do
    subject { described_class.all(params) }

    let(:params) do
      {
        path: "Engineering Candidates/R\u00e9sum\u00e9s",
        page: 1,
        per_page: 10,
        search: 'Engineering Candidates/',
        'sort_by[path]' => 'asc',
        'sort_by[size]' => 'asc',
        'sort_by[modified_at_datetime]' => 'asc',
      }
    end

    let(:folders) do
      [
        {
          'id' => 1,
          'path' => "Engineering Candidates/R\u00e9sum\u00e9s/Needs Review",
          'display_name' => 'Needs Review',
          'type' => 'directory',
          'size' => nil,
          'mtime' => '2014-05-15T20:26:18+00:00',
          'crc32' => nil,
          'md5' => nil,
          'provided_mtime' => '2014-05-15T20:26:18+00:00',
          'permissions' => 'rwd',
          'subfolders_locked?' => false,
        },
        {
          'id' => 2,
          'path' => "Engineering Candidates/R\u00e9sum\u00e9s/John Smith.docx",
          'display_name' => 'John Smith.docx',
          'type' => 'file',
          'size' => 61_440,
          'mtime' => '2014-05-15T18:34:51+00:00',
          'crc32' => 'f341cc60',
          'md5' => 'b67236f5bcd29d1307d574fb9fe585b5',
          'provided_mtime' => '2014-05-15T18:34:51+00:00',
          'permissions' => 'rwd',
          'subfolders_locked?' => false,
        },
        {
          'id' => 3,
          'path' => "Engineering Candidates/R\u00e9sum\u00e9s/Mary Jones.pdf",
          'display_name' => 'Mary Jones.pdf',
          'type' => 'file',
          'size' => 19_946,
          'mtime' => '2014-05-15T18:36:03+00:00',
          'crc32' => 'a720a234',
          'md5' => '02c442ecc0d499bf443fa8fd444c2933',
          'provided_mtime' => '2014-05-15T18:36:03+00:00',
          'permissions' => 'rwd',
          'subfolders_locked?' => false,
        }
      ]
    end

    before do
      stub_request(:get, 'https://koshigoe.brickftp.com/api/rest/v1/folders/Engineering%20Candidates%2FR%C3%A9sum%C3%A9s?page=1&per_page=10&search=Engineering%20Candidates%2F&sort_by%5Bmodified_at_datetime%5D=asc&sort_by%5Bpath%5D=asc&sort_by%5Bsize%5D=asc')
        .with(basic_auth: ['xxxxxxxx', 'x'])
        .to_return(body: folders.to_json)
    end

    it 'return Array of BrickFTP::API::Folder' do
      is_expected.to all(be_an_instance_of(BrickFTP::API::Folder))
    end

    it 'set attributes' do
      folders = subject
      expect(folders.last.id).to eq 3
      expect(folders.last.path).to eq "Engineering Candidates/R\u00e9sum\u00e9s/Mary Jones.pdf"
      expect(folders.last.display_name).to eq 'Mary Jones.pdf'
      expect(folders.last.type).to eq 'file'
      expect(folders.last.size).to eq 19_946
      expect(folders.last.mtime).to eq '2014-05-15T18:36:03+00:00'
      expect(folders.last.crc32).to eq 'a720a234'
      expect(folders.last.md5).to eq '02c442ecc0d499bf443fa8fd444c2933'
      expect(folders.last.provided_mtime).to eq '2014-05-15T18:36:03+00:00'
      expect(folders.last.permissions).to eq 'rwd'
      expect(folders.last.subfolders_locked?).to eq false
    end
  end

  describe '.create' do
    subject { described_class.create(path: 'path') }

    context 'success' do
      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/folders/path')
          .with(basic_auth: ['xxxxxxxx', 'x'])
          .to_return(status: 201, body: '[]')
      end

      it 'return instance of BrickFTP::API::Folder' do
        is_expected.to be_an_instance_of BrickFTP::API::Folder
      end
    end

    context 'failure' do
      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/folders/path')
          .with(basic_auth: ['xxxxxxxx', 'x'])
          .to_return(status: 500, body: { 'error' => 'xxxxxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end
  end
end
