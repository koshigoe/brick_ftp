require 'tempfile'

module BrickFTP
  module Utils
    class ChunkIO
      include Enumerable

      attr_reader :io, :chunk_size

      # Wrap IO object.
      #
      # @param [IO, StringIO] io an IO object.
      # @param [Integer] chunk_size Size of chunk.
      #   This option is ignored if `io` is `StringIO`.
      #
      def initialize(io, chunk_size: nil)
        @io = io
        @chunk_size = chunk_size
      end

      # Iterate with chunked IO object.
      #
      # @yield [chunk] Give a chunk IO object to block.
      # @yieldparam [IO] chunk a chunked IO object.
      #
      def each(&block)
        return enum_for(__method__) unless block

        if chunk_size && io.is_a?(IO)
          each_chunk(&block)
        else
          whole(&block)
        end
      end

      private

      def whole
        yield io
      end

      def each_chunk
        eof = false
        offset = 0
        until eof
          Tempfile.create('chunk-io') do |chunk|
            copied = IO.copy_stream(io, chunk, chunk_size, offset)
            eof = copied.zero?
            next if eof

            offset += copied
            chunk.rewind

            yield chunk
          end
        end
      end
    end
  end
end
