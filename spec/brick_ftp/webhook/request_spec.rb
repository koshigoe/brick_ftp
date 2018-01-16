require 'spec_helper'

RSpec.describe BrickFTP::Webhook::Request, type: :lib do
  describe '.from_query_string' do
    subject { described_class.from_query_string(query) }

    let(:query) do
      'action=create&interface=ftp&path=%2Fpath%2Fto%2Ffile.txt&at=2016-10-20T00:00:00%2B00:00&username=user&type=file'
    end

    it { is_expected.to be_an_instance_of(BrickFTP::Webhook::Request) }

    it 'set webhook parameters' do
      expect(subject.action).to eq 'create'
      expect(subject.interface).to eq 'ftp'
      expect(subject.path).to eq '/path/to/file.txt'
      expect(subject.at).to eq '2016-10-20T00:00:00+00:00'
      expect(subject.username).to eq 'user'
      expect(subject.type).to eq 'file'
    end
  end
end
