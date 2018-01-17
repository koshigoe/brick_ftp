require 'spec_helper'
require 'tempfile'

RSpec.describe BrickFTP::Utils::ChunkIO do
  describe '#each_chunk' do
    context 'chunk_size is nil' do
      it 'chunk has whole data' do
        Tempfile.create do |io|
          io.write('DATA')
          io.rewind

          res = ''
          called = 0
          described_class.new(io).each_chunk do |chunk|
            res << chunk.read
            called += 1
          end
          expect(res).to eq 'DATA'
          expect(called).to eq 1
        end
      end
    end

    context 'chunk_size is not nil' do
      it 'split by chunk_size' do
        Tempfile.create do |io|
          io.write('DATA')
          io.rewind

          res = ''
          called = 0
          described_class.new(io).each_chunk(chunk_size: 1) do |chunk|
            res << chunk.read
            called += 1
          end
          expect(res).to eq 'DATA'
          expect(called).to eq 4
        end
      end
    end
  end
end
