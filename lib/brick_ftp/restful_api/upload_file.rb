# frozen_string_literal: true

require 'uri'

module BrickFTP
  module RESTfulAPI
    # Overview of uploading
    #
    # @see https://developers.files.com/#overview-of-uploading Overview of uploading
    #
    # ### Uploading files using the REST API is done in 3 stages:
    #
    # 1. {https://developers.files.com/#starting-a-new-upload Start a new upload} by sending a request to REST API to indicate intent to upload a file.
    # 2. {https://developers.files.com/#uploading-the-file-or-file-parts Upload the file} to the URL(s) provided by the REST API, possibly in parts via multiple uploads.
    # 3. {https://developers.files.com/#completing-an-upload Complete the upload} by notifying the REST API that the file upload has completed.
    #
    class UploadFile
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      CHUNK_SIZE_RANGE = (5_242_880..5_368_709_120).freeze

      # @!attribute [rw] path
      #   Full path of the file or folder. Maximum of 550 characters.
      # @!attribute [rw] data
      #   data to upload
      # @!attribute [rw] chunk_size
      #   the chunk sizes are required to be between 5 MB and 5 GB.
      Params = Struct.new(
        'UploadFileParams',
        :path,
        :data,
        :chunk_size,
        keyword_init: true
      )

      # At this point, you are to send a PUT request to the returned upload_uri with the file data,
      # along with the headers and parameters provided to you from BrickFTP.
      #
      # The upload_uri link is signed by BrickFTP and must be used within 15 minutes.
      # You will receive an HTTP 200 response with no body upon successful upload.
      #
      # Should you wish to upload the file in multiple parts (required if the file size exceeds 5 GB)
      # you will need to request an additional upload URL for the next part.
      #
      # @param [BrickFTP::RESTfulAPI::UploadFile::Params] params parameters
      # @return [BrickFTP::Types::File]
      #
      def call(params) # rubocop:disable Metrics/AbcSize
        params = Params.new(params.to_h).to_h.compact
        path = params.delete(:path)
        data = params.delete(:data)
        chunk_size = params.delete(:chunk_size)

        chunk_size = adjust_chunk_size(data, chunk_size)
        validate_range_of_chunk_size!(chunk_size)

        upload = StartUpload.new(client).call(path: path)
        chunk_io = BrickFTP::Utils::ChunkIO.new(data, chunk_size: chunk_size)

        rest = data.size
        chunk_io.each do |chunk|
          rest -= client.upload_file(upload.http_method, upload.upload_uri, chunk)
          break if !chunk_size || rest <= 0

          upload = ContinueUpload.new(client).call(path: path, ref: upload.ref, part: upload.part_number + 1)
        end
        CompleteUpload.new(client).call(path: path, ref: upload.ref)
      end

      private

      # To single uploading if chunk_size less than equals data size.
      def adjust_chunk_size(data, chunk_size)
        chunk_size && chunk_size >= data.size ? nil : chunk_size
      end

      def validate_range_of_chunk_size!(chunk_size)
        raise ArgumentError, 'chunk_size must be between 5MB and 5GB' if chunk_size && !CHUNK_SIZE_RANGE.cover?(chunk_size)
      end
    end
  end
end
