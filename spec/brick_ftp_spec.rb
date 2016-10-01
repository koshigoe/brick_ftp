require 'spec_helper'

describe BrickFTP do
  it 'has a version number' do
    expect(BrickFTP::VERSION).not_to be nil
  end

  describe '.config' do
    subject { described_class.config }

    it { is_expected.to be_an_instance_of BrickFTP::Configuration }
  end
end
