# ``FileType``

Detect file types from magic bytes, MIME metadata, container contents, and UTI identifiers.

## Overview

`FileType` identifies file formats from `Data`, `URL`, or `FileHandle`. It can return metadata for known formats, report whether detection only needs a prefix or the full file, and narrow matching to MIME major groups when the caller already knows the broad file family.

On Apple platforms (macOS 11+, iOS 14+, tvOS 14+, watchOS 7+, visionOS 1+), file types can also be resolved from Uniform Type Identifier strings or `UTType` values.

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

- ``FileType/detect(in:matching:)-(_,FileTypeMIMEGroup)``
- ``FileType/detect(in:matching:)-(_,[FileTypeMIMEGroup])``
- ``FileType/detect(contentsOf:matching:)-(_,FileTypeMIMEGroup)``
- ``FileType/detect(contentsOf:matching:)-(_,[FileTypeMIMEGroup])``
- ``FileType/detect(using:matching:)-(_,FileTypeMIMEGroup)``
- ``FileType/detect(using:matching:)-(_,[FileTypeMIMEGroup])``

### UTI Detection (Apple Platforms)

- ``FileType/detect(uti:)``
- ``FileType/detect(utType:)``

### Metadata And Planning

- ``FileType/all(for:)-(FileTypeExtension)``
- ``FileType/all(for:)-(FileTypeMIMEGroup)``
- ``FileType/minimumPrefixBytes(for:)-(FileTypeExtension)``
- ``FileType/minimumPrefixBytes(for:)-([FileTypeExtension])``
- ``FileType/minimumPrefixBytes(for:)-(FileTypeMIMEGroup)``
- ``FileType/minimumPrefixBytes(for:)-([FileTypeMIMEGroup])``
- ``FileType/dataRequirement(for:)-(FileTypeExtension)``
- ``FileType/dataRequirement(for:)-([FileTypeExtension])``
- ``FileType/dataRequirement(for:)-(FileTypeMIMEGroup)``
- ``FileType/dataRequirement(for:)-([FileTypeMIMEGroup])``

### Compatibility APIs

- ``FileType/getBytesCountFor(type:)``
- ``FileType/getBytesCountFor(types:)``
- ``FileType/getFor(type:)``
- ``FileType/getFor(data:)``
