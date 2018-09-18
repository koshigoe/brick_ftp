# frozen_string_literal: true

require 'spec_helper'
require 'tempfile'

RSpec.describe BrickFTP::Utils::ChunkIO do
  describe '#each' do
    context 'chunk_size is nil' do
      it 'chunk has whole data' do
        Tempfile.create('spec') do |io|
          io.write('DATA')
          io.rewind

          res = +''
          called = 0
          described_class.new(io).each do |chunk|
            res << chunk.read
            called += 1
          end
          expect(res).to eq 'DATA'
          expect(called).to eq 1
        end
      end
    end

    context 'chunk_size is not nil' do
      context 'data is a StringIO' do
        it 'chunk has whole data' do
          io = StringIO.new('DATA')
          io.rewind

          res = +''
          called = 0
          described_class.new(io, chunk_size: 1).each do |chunk|
            res << chunk.read
            called += 1
          end
          expect(res).to eq 'DATA'
          expect(called).to eq 1
        end
      end

      context 'data is not a StringIO' do
        it 'split by chunk_size' do
          Tempfile.create('spec') do |io|
            io.write('DATA')
            io.rewind

            res = +''
            called = 0
            described_class.new(io, chunk_size: 1).each do |chunk|
              res << chunk.read
              called += 1
            end
            expect(res).to eq 'DATA'
            expect(called).to eq 4
          end
        end
      end
    end

    context 'without block' do
      it 'return Enumerator' do
        Tempfile.create('spec') do |io|
          io.write('DATA')
          io.rewind

          enum = described_class.new(io, chunk_size: 1).each
          expect(enum).to be_an_instance_of(Enumerator)

          res = +''
          called = 0
          enum.each do |chunk|
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
