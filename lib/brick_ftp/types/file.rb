# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # The file/folder object
    #
    # @see https://developers.brickftp.com/#the-file-folder-object The file/folder object
    #
    # ATTRIBUTE          | TYPE     | DESCRIPTION
    # ------------------ | -------- | -----------
    # id                 | integer  | Globally unique identifier of each file.
    # path               | string   | Full path of the file or folder. Maximum of 550 characters.
    # display_name       | string   | Name of the file or folder without path.
    # type               | enum     | Either `file` or `directory` (meaning folder).
    # size               | integer  | Size of the file in bytes. Will be 0 for a folder.
    # mtime              | datetime | Date of the file/folder's last modification.
    # provided_mtime     | datetime | Client-provided date of the file/folder's last modification.
    # crc32              | string   | CRC32 for the file, if available.
    # md5                | string   | MD5 hash for the file, if available.
    # region             | string   | The geographic region that a file is stored in.
    # permissions        | string   | Your permissions on the file/folder. Will be one of the following:<br>`p` (list/preview only), `r` (read-only), `w` (write-only), `rw` (read/write), `rwd` (read/write/delete).
    # download_uri       | string   | URL to download the file, if requested.
    # subfolders_locked? | integer  | A value of `1` indicates that the Lock-subfolders setting is enabled on a folder.
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
      :download_uri,
      :subfolders_locked?,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
