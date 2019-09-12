# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # The File object
    #
    # @see https://developers.files.com/#the-file-object The File object
    #
    # ATTRIBUTE          | TYPE     | DESCRIPTION
    # ------------------ | -------- | -----------
    # id                 | integer  | File/Folder ID
    # path               | string   | File/Folder path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # display_name       | string   | File/Folder display name
    # type               | string   | Type: `directory` or `file`.
    # size               | integer  | File/Folder size
    # mtime              | datetime | File last modified date/time, according to the server. This is the timestamp of the last Files.com operation of the file, regardless of what modified timestamp was sent.
    # provided_mtime     | datetime | File last modified date/time, according to the client who set it. Files.com allows desktop, FTP, SFTP, and WebDAV clients to set modified at times. This allows Desktop<->Cloud syncing to preserve modified at times.
    # crc32              | string   | File CRC32 checksum. This is sometimes delayed, so if you get a blank response, wait and try again.
    # md5                | string   | File MD5 checksum. This is sometimes delayed, so if you get a blank response, wait and try again.
    # region             | string   | Region location
    # permissions        | string   | A short string representing the current user's permissions. Can be `r`,`w`,`p`, or any combination
    # subfolders_locked? | boolean  | Are subfolders locked and unable to be modified?
    # download_uri       | string   | Link to download file. Provided only in response to a download request.
    # priority_color     | string   | Bookmark/priority color of file/folder
    # preview_id         | integer  | File preview ID
    # preview            | ?        | File preview
    #
    File = Struct.new(
      'File',
      :id,
      :path,
      :display_name,
      :type,
      :size,
      :mtime,
      :provided_mtime,
      :crc32,
      :md5,
      :region,
      :permissions,
      :subfolders_locked?,
      :download_uri,
      :priority_color,
      :preview_id,
      :preview,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
