require 'spec_helper'

RSpec.describe BrickFTP::Authentication, type: :lib do
  describe '.cookie' do
    subject { described_class.cookie(session) }

    let(:session) { BrickFTP::Authentication::Session.new(id: 'xxxxxxxx') }

    it 'return instance of CGI::Cookie' do
      is_expected.to be_an_instance_of CGI::Cookie
    end

    it 'name is BrickFTP' do
      expect(subject.name).to eq 'BrickFTP'
    end

    it 'value is session id' do
      expect(subject.value).to eq %w(xxxxxxxx)
    end
  end
end
