# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::CoreExt::Hash::SymbolizeKeys, type: :lib do
  describe '#symbolize_keys' do
    it 'convert keys to symbol' do
      hash = { 'str' => 1, nil => 2 }
      hash.extend(BrickFTP::CoreExt::Hash::SymbolizeKeys)

      expect(hash.symbolize_keys).to eq(str: 1, nil => 2)
    end
  end
end
