# ``FileType``

Detect file types from magic bytes, MIME metadata, and container contents.

## Overview

`FileType` identifies file formats from `Data`, `URL`, or `FileHandle`. It can return metadata for known formats, report whether detection only needs a prefix or the full file, and narrow matching to MIME major groups when the caller already knows the broad file family.

## Topics

### Core Types

- ``FileType``
- ``FileTypeExtension``
- ``FileTypeMIMEGroup``
- ``FileTypeDataRequirement``

### Detected File Metadata

- ``FileType/type``
- ``FileType/ext``
- ``FileType/mime``
- ``FileType/mimeGroup``
- ``FileTypeExtension/canonicalFileExtension``

### Detection

- ``FileType/detect(in:)``
- ``FileType/detect(contentsOf:)``
- ``FileType/detect(using:)``

### Detection Filters

- ``FileType/detect(in:matching:)``
- ``FileType/detect(contentsOf:matching:)``
- ``FileType/detect(using:matching:)``

### Metadata And Planning

- ``FileType/all(for:)``
- ``FileType/minimumPrefixBytes(for:)``
- ``FileType/dataRequirement(for:)``

### Compatibility APIs

- ``FileType/getBytesCountFor(type:)``
- ``FileType/getBytesCountFor(types:)``
- ``FileType/getFor(type:)``
- ``FileType/getFor(data:)``
