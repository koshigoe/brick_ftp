# frozen_string_literal: true

module BrickFTP
  module Types
    # rubocop:disable Metrics/LineLength, Layout/CommentIndentation
    Upload = Struct.new(
      'Upload',
      :ref,                  # string          | Unique identifier to reference this file upload. This identifier is needed for
                             #                 | subsequent requests to the REST API to complete the upload or request more upload URLs.
      :http_method,          # string          | Value is PUT or POST, and is the HTTP method used when uploading the file to S3 at the upload_uri.
      :upload_uri,           # string          | The URL where the file is uploaded to.
      :partsize,             # integer         | Recommended size of upload. When uploading file pieces, the piece sizes are required
                             #                 | to be between 5 MB and 5 GB (except the last part). This value provides a recommended size
                             #                 | to upload for this part without adding another part.
      :part_number,          # integer         | Number of this part, which is always between 1 and 10,000, and will always be 1
                             #                 | for the first upload URL at the beginning of uploading a new file.
      :available_parts,      # integer         | Number of parts available for this upload. For new file uploads this value is always 10,000,
                             #                 | but it may be smaller for other uploads. When requesting more upload URLs from the REST API,
                             #                 | the part numbers must be between 1 and this number.
      :headers,              # key-value pairs | A list of required headers and their exact values to send in the file upload.
                             #                 | It may be empty if no headers with fixed values are required.
      :parameters,           # key-value pairs | A list of required parameters and their exact values to send in the file upload.
                             #                 | If any values are in this array, it is implied that the upload request is formatted appropriately
                             #                 | to send form data parameters. It will always be empty if the body of the request is specified to
                             #                 | be where the file upload data goes (see send below).
      :send,                 # key-value pairs | This is an array of values to be sent in the file upload request.
                             #                 | Possible sub-values are partsize, partdata, file, and Content-Type:
                             #                 |   - `file`: where to put the file data for the entire file upload
                             #                 |   - `partdata`: where to put the file data for this part
                             #                 |   - `partsize`: where to put the size of the upload for this file part
                             #                 |   - `Content-Type`: where to put the Content-Type of the file (which can have no bearing on the file's actual type)
                             #                 | Possible values for these parameters:
                             #                 |   - `body`: this information is the body of the PUT or POST request
                             #                 |   - `required-header <header name>`: this information goes in the named header
                             #                 |   - `required-parameter <parameter name>`: this information goes in the named parameter,
                             #                 |      and implies this request is formatted appropriately to send form data parameters
      :path,                 # string          | Intended destination path of the file upload. Path may change upon finalization,
                             #                 | depending on existance of another upload to the same location and the site's overwrite setting.
      :action,               # string          | Value is always write or put for this action.
      :ask_about_overwrites, # boolean         | If true, a file by this name already exists and will be overwritten when this upload completes if it continues.
      :expires,              # datetime        | <undocumented>
      :next_partsize,        # integer         | <undocumented>
      keyword_init: true
    )
    # rubocop:enable Metrics/LineLength, Layout/CommentIndentation
  end
end
