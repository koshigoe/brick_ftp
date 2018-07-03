Changelog
====


[unreleased](https://github.com/koshigoe/brick_ftp/compare/v0.8.2...master)
----

[Full Changelog](https://github.com/koshigoe/brick_ftp/compare/v0.8.2...master)

### Enhancements:

### Fixed Bugs:

### Breaking Changes:

- [Dropping support for Ruby 2.2](https://github.com/koshigoe/brick_ftp/pull/104)
    - Set `frozen_string_literal: true`


[0.8.2](https://github.com/koshigoe/brick_ftp/compare/v0.8.1...v0.8.2)
----

[Full Changelog](https://github.com/koshigoe/brick_ftp/compare/v0.8.1...v0.8.2)

### Enhancements:

- [#96](https://github.com/koshigoe/brick_ftp/pull/96) Add display key to history (by [terencedignon](https://github.com/terencedignon))

### Fixed Bugs:

### Breaking Changes:

### Others

- [#98](https://github.com/koshigoe/brick_ftp/pull/98) Documentation is out of date (by [terencedignon](https://github.com/terencedignon))


[v0.8.1](https://github.com/koshigoe/brick_ftp/compare/v0.8.0...v0.8.1)
----

[Full Changelog](https://github.com/koshigoe/brick_ftp/compare/v0.8.0...v0.8.1)

### Enhancements:

- [#94](https://github.com/koshigoe/brick_ftp/pull/94) Fix method signature of `#to_json` and `#as_json`

### Fixed Bugs:

### Breaking Changes:


[v0.8.0](https://github.com/koshigoe/brick_ftp/compare/v0.7.1...v0.8.0)
----

[Full Changelog](https://github.com/koshigoe/brick_ftp/compare/v0.7.1...v0.8.0)

### Enhancements:

### Fixed Bugs:

- [#92](https://github.com/koshigoe/brick_ftp/pull/92) Re-Overwrite `as_json` to avoid to too much loop.
    - fixes [#91](https://github.com/koshigoe/brick_ftp/issues/91)

### Breaking Changes:

- [#92](https://github.com/koshigoe/brick_ftp/pull/92)
    - Change type of key of returned Hash object from `BrickFTP::API::Base#as_json` to `String`.
    - Initialize `BrickFTP::API::Base#properties` with all defined attributes.


[v0.7.1](https://github.com/koshigoe/brick_ftp/compare/v0.7.0...v0.7.1)
----

[Full Changelog](https://github.com/koshigoe/brick_ftp/compare/v0.7.0...v0.7.1)

### Enhancements:

- [#89](https://github.com/koshigoe/brick_ftp/pull/89) [Experimental] Allow to execute each steps of multi part uploading.

### Fixed Bugs:

### Breaking Changes:


[v0.7.0](https://github.com/koshigoe/brick_ftp/compare/v0.6.1...v0.7.0)
----

[Full Changelog](https://github.com/koshigoe/brick_ftp/compare/v0.6.1....v0.7.0)

### Enhancements:

- [#80](https://github.com/koshigoe/brick_ftp/pull/80) Use Rubocop.
- [#85](https://github.com/koshigoe/brick_ftp/pull/85) Allow `BrickFTP::Client#upload_file` to multi part uploading.

### Fixed Bugs:

### Breaking Changes:

- [#87](https://github.com/koshigoe/brick_ftp/pull/87) Support Ruby >= 2.2.0


[v0.6.1](https://github.com/koshigoe/brick_ftp/compare/v0.6.0...v0.6.1)
----

[Full Changelog](https://github.com/koshigoe/brick_ftp/compare/v0.6.0...v0.6.1)

### Enhancements:

### Fixed Bugs:

- [#76](https://github.com/koshigoe/brick_ftp/pull/76) Don't raise unexpected exception even if it can't expand path `~`.

### Breaking Changes:


[v0.6.0](https://github.com/koshigoe/brick_ftp/compare/v0.5.1...v0.6.0)
----

[Full Changelog](https://github.com/koshigoe/brick_ftp/compare/v0.5.1...v0.6.0)

### Enhancements:

### Fixed Bugs:

### Breaking Changes:

- [#72](https://github.com/koshigoe/brick_ftp/pull/72) Improve accessor of API properties
    - Cannot access some API properties named same as methods of Ruby's Object.
        - e.g. `send` property of [File Uploading](https://brickftp.com/docs/rest-api/file-uploading/)
        - Use `#properties` to access properties


[v0.5.1](https://github.com/koshigoe/brick_ftp/compare/v0.5.0...v0.5.1)
----

[Full Changelog](https://github.com/koshigoe/brick_ftp/compare/v0.5.0...v0.5.1)

### Enhancements:

### Fixed Bugs:

- [#67](https://github.com/koshigoe/brick_ftp/pull/67) Fix wrong API document.
- [#69](https://github.com/koshigoe/brick_ftp/pull/69) sanitize instance variable names (fixed by [terencedignon](https://github.com/terencedignon))


[v0.5.0](https://github.com/koshigoe/brick_ftp/compare/v0.4.2...v0.5.0)
----

[Full Changelog](https://github.com/koshigoe/brick_ftp/compare/v0.4.2...v0.5.0)

### Enhancements:

- [#65](https://github.com/koshigoe/brick_ftp/pull/65) Allow to specify resource as ID

### Fixed Bugs:


[0.4.2](https://github.com/koshigoe/brick_ftp/compare/v0.4.1...v0.4.2)
----

[Full Changelog](https://github.com/koshigoe/brick_ftp/compare/v0.4.1...v0.4.2)

### Enhancements:

- [#62](https://github.com/koshigoe/brick_ftp/pull/62) Add property `display_name` to File API ([terencedignon](https://github.com/terencedignon))
- [#63](https://github.com/koshigoe/brick_ftp/pull/63) Add property `display_name` to Folder API

### Fixed Bugs:


[0.4.1](https://github.com/koshigoe/brick_ftp/compare/v0.4.0...v0.4.1)
----

[Full Changelog](https://github.com/koshigoe/brick_ftp/compare/v0.4.0...v0.4.1)

### Enhancements:

### Fixed Bugs:

- [#58](https://github.com/koshigoe/brick_ftp/pull/58) Fix wrong path escape
    - reported by [terencedignon](https://github.com/terencedignon)


[0.4.0](https://github.com/koshigoe/brick_ftp/compare/v0.3.8...v0.4.0)
----

[Full Changelog](https://github.com/koshigoe/brick_ftp/compare/v0.3.8...v0.4.0)

### Enhancements:

- [#36](https://github.com/koshigoe/brick_ftp/pull/36) Add Changelog.
- [#46](https://github.com/koshigoe/brick_ftp/pull/46) Add CLI.
- [#53](https://github.com/koshigoe/brick_ftp/pull/53) Allow to pass `action=stat` to Files: Download API.

### Fixed Bugs:
