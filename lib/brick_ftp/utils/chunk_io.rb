module BrickFTP
  module Utils
    class ChunkIO
      attr_reader :io

      # Wrap IO object.
      #
      # @param [IO] io an IO object.
      #
      def initialize(io)
        @io = io
      end

      # Iterate with chunked IO object.
      #
      # @param [Integer] chunk_size Size of chunk.
      # @yield [chunk] Give a chunk IO object to block.
      # @yieldparam [StringIO] chunk a chunked IO object.
      #
      def each_chunk(chunk_size: nil)
        if chunk_size
          offset = 0
          loop do
            chunk = StringIO.new
            copied = IO.copy_stream(io, chunk, chunk_size, offset)
            break if copied.zero?

            offset += copied
            chunk.rewind

            yield chunk if copied
          end
        else
          yield io
        end
      end
    end
  end
end
