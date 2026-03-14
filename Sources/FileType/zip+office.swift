import CZlib
import Foundation

struct ZipHeader {
    let filename: String
    var mimeType: String?
}

private enum ZipCompressionMethod: Int {
    case stored = 0
    case deflate = 8
}

private struct ZipEntry {
    let filename: String
    let compressionMethodValue: Int
    let compressedSize: Int
    let uncompressedSize: Int
    let localHeaderOffset: Int
}

private let zipLocalFileHeaderSignature = UInt32(0x0403_4B50)
private let zipCentralDirectoryHeaderSignature = UInt32(0x0201_4B50)
private let zipEndOfCentralDirectorySignature = UInt32(0x0605_4B50)
private let maximumZipDirectoryEntries = 2_048
private let maximumZipCommentLength = 65_535
private let maximumZipTextEntrySize = 1_048_576

private struct OpenXMLZipDetectionState {
    var hasContentTypesEntry = false
    var hasParsedContentTypesEntry = false
    var hasUnparseableContentTypes = false
    var hasWordDirectory = false
    var hasPresentationDirectory = false
    var hasSpreadsheetDirectory = false
    var hasThreeDimensionalModelEntry = false
}

func isZipArchive(_ data: Data) -> Bool {
    data.starts(with: [0x50, 0x4B, 0x03, 0x04])
        || data.starts(with: [0x50, 0x4B, 0x03, 0x06])
        || data.starts(with: [0x50, 0x4B, 0x03, 0x08])
        || data.starts(with: [0x50, 0x4B, 0x05, 0x04])
        || data.starts(with: [0x50, 0x4B, 0x05, 0x06])
        || data.starts(with: [0x50, 0x4B, 0x05, 0x08])
        || data.starts(with: [0x50, 0x4B, 0x07, 0x04])
        || data.starts(with: [0x50, 0x4B, 0x07, 0x06])
        || data.starts(with: [0x50, 0x4B, 0x07, 0x08])
}

func detectZipFileType(_ data: Data) -> FileTypeMatchType? {
    guard isZipArchive(data) else {
        return nil
    }

    var openXMLState = OpenXMLZipDetectionState()
    var hasJarManifest = false
    var hasAndroidDex = false

    if let detectedType = scanZipEntries(
        data,
        { header in
            updateOpenXMLZipDetectionState(&openXMLState, filename: header.filename)

            switch header.filename {
            case "META-INF/mozilla.rsa":
                return .xpi

            case "META-INF/MANIFEST.MF":
                hasJarManifest = true

            case "mimetype":
                if let mimeType = header.mimeType, let fileType = zipFileType(for: mimeType) {
                    return fileType
                }

            case "[Content_Types].xml":
                openXMLState.hasContentTypesEntry = true

                if let mimeType = header.mimeType, let fileType = zipFileType(for: mimeType) {
                    openXMLState.hasParsedContentTypesEntry = true
                    return fileType
                }

                openXMLState.hasUnparseableContentTypes = true

            default:
                if isAndroidDexEntry(header.filename) {
                    hasAndroidDex = true
                }
            }

            return nil
        })
    {
        return detectedType
    }

    if hasAndroidDex {
        return .apk
    }

    if hasJarManifest {
        return .jar
    }

    return fallbackOpenXMLFileType(from: openXMLState) ?? .zip
}

private func scanZipEntries(_ data: Data, _ visit: (ZipHeader) -> FileTypeMatchType?)
    -> FileTypeMatchType?
{
    guard let entries = readZipEntries(from: data) else {
        return nil
    }

    for entry in entries {
        var zipHeader = ZipHeader(filename: entry.filename)

        if entry.filename == "mimetype" || entry.filename == "[Content_Types].xml",
            let fileData = readZipEntryData(from: data, entry: entry)
        {
            if entry.filename == "mimetype" {
                zipHeader.mimeType = String(data: fileData, encoding: .utf8)?
                    .trimmingCharacters(in: .whitespacesAndNewlines)
            } else if let contentTypes = String(data: fileData, encoding: .utf8) {
                zipHeader.mimeType = openXMLPackageMIMEType(from: contentTypes)
            }
        }

        if let detectedType = visit(zipHeader) {
            return detectedType
        }
    }

    return nil
}

private func readZipEntries(from data: Data) -> [ZipEntry]? {
    guard
        let endOfCentralDirectoryOffset = findEndOfCentralDirectoryOffset(in: data),
        let entryCount = data.getInt16LE(offset: endOfCentralDirectoryOffset + 10),
        let centralDirectoryOffset = data.getInt32LE(offset: endOfCentralDirectoryOffset + 16),
        (0...maximumZipDirectoryEntries).contains(entryCount)
    else {
        return nil
    }

    var position = centralDirectoryOffset
    var entries: [ZipEntry] = []
    entries.reserveCapacity(entryCount)

    for _ in 0..<entryCount {
        guard
            data.getUInt32LE(offset: position) == zipCentralDirectoryHeaderSignature,
            let compressionMethodValue = data.getInt16LE(offset: position + 10),
            let compressedSize = data.getInt32LE(offset: position + 20),
            let uncompressedSize = data.getInt32LE(offset: position + 24),
            let filenameLength = data.getInt16LE(offset: position + 28),
            let extraFieldLength = data.getInt16LE(offset: position + 30),
            let fileCommentLength = data.getInt16LE(offset: position + 32),
            let localHeaderOffset = data.getInt32LE(offset: position + 42)
        else {
            return nil
        }

        let filenameStart = position + 46
        let filenameEnd = filenameStart + filenameLength
        let nextPosition = filenameEnd + extraFieldLength + fileCommentLength

        guard data.hasBytes(in: position..<nextPosition) else {
            return nil
        }

        let filenameRange = filenameStart..<filenameEnd
        guard
            let filename = data.getString(from: filenameRange)
                ?? data.getString(from: filenameRange, encoding: .ascii)
        else {
            return nil
        }

        entries.append(
            ZipEntry(
                filename: filename,
                compressionMethodValue: compressionMethodValue,
                compressedSize: compressedSize,
                uncompressedSize: uncompressedSize,
                localHeaderOffset: localHeaderOffset
            )
        )
        position = nextPosition
    }

    return entries
}

private func findEndOfCentralDirectoryOffset(in data: Data) -> Int? {
    let searchStart = max(0, data.count - (22 + maximumZipCommentLength))
    var searchRange = searchStart..<data.count
    let signature = Data([0x50, 0x4B, 0x05, 0x06])

    while let matchRange = data.range(of: signature, options: .backwards, in: searchRange) {
        let offset = matchRange.lowerBound

        guard
            data.getUInt32LE(offset: offset) == zipEndOfCentralDirectorySignature,
            let commentLength = data.getInt16LE(offset: offset + 20)
        else {
            return nil
        }

        if offset + 22 + commentLength == data.count {
            return offset
        }

        searchRange = searchStart..<offset
    }

    return nil
}

private func readZipEntryData(from data: Data, entry: ZipEntry) -> Data? {
    guard
        entry.compressedSize >= 0,
        entry.uncompressedSize >= 0,
        entry.uncompressedSize <= maximumZipTextEntrySize,
        entry.compressedSize <= maximumZipTextEntrySize,
        data.getUInt32LE(offset: entry.localHeaderOffset) == zipLocalFileHeaderSignature,
        let filenameLength = data.getInt16LE(offset: entry.localHeaderOffset + 26),
        let extraFieldLength = data.getInt16LE(offset: entry.localHeaderOffset + 28)
    else {
        return nil
    }

    let dataOffset = entry.localHeaderOffset + 30 + filenameLength + extraFieldLength
    let dataEnd = dataOffset + entry.compressedSize

    guard
        data.hasBytes(in: dataOffset..<dataEnd),
        let compressionMethod = ZipCompressionMethod(rawValue: entry.compressionMethodValue)
    else {
        return nil
    }

    let entryData = data.subdata(in: dataOffset..<dataEnd)

    switch compressionMethod {
    case .stored:
        return entryData

    case .deflate:
        return inflateRaw(entryData, uncompressedSize: entry.uncompressedSize)
    }
}

private func inflateRaw(_ data: Data, uncompressedSize: Int) -> Data? {
    guard uncompressedSize >= 0 else {
        return nil
    }

    if uncompressedSize == 0 {
        return Data()
    }

    var stream = z_stream()
    let initStatus = inflateInit2_(
        &stream,
        -MAX_WBITS,
        ZLIB_VERSION,
        Int32(MemoryLayout<z_stream>.size)
    )

    guard initStatus == Z_OK else {
        return nil
    }

    defer {
        inflateEnd(&stream)
    }

    var output = Data(count: uncompressedSize)

    let status = data.withUnsafeBytes { inputBuffer in
        output.withUnsafeMutableBytes { outputBuffer -> Int32 in
            guard
                let inputBaseAddress = inputBuffer.baseAddress?.assumingMemoryBound(to: Bytef.self),
                let outputBaseAddress = outputBuffer.baseAddress?.assumingMemoryBound(
                    to: Bytef.self)
            else {
                return Z_DATA_ERROR
            }

            stream.next_in = UnsafeMutablePointer(mutating: inputBaseAddress)
            stream.avail_in = uInt(data.count)
            stream.next_out = outputBaseAddress
            stream.avail_out = uInt(uncompressedSize)

            return inflate(&stream, Z_FINISH)
        }
    }

    guard status == Z_STREAM_END else {
        return nil
    }

    output.count = Int(stream.total_out)
    return output
}

private func zipFileType(for mimeType: String) -> FileTypeMatchType? {
    switch mimeType.lowercased() {
    case "application/epub+zip":
        return .epub
    case "application/vnd.oasis.opendocument.text":
        return .odt
    case "application/vnd.oasis.opendocument.text-template":
        return .ott
    case "application/vnd.oasis.opendocument.spreadsheet":
        return .ods
    case "application/vnd.oasis.opendocument.spreadsheet-template":
        return .ots
    case "application/vnd.oasis.opendocument.presentation":
        return .odp
    case "application/vnd.oasis.opendocument.presentation-template":
        return .otp
    case "application/vnd.oasis.opendocument.graphics":
        return .odg
    case "application/vnd.oasis.opendocument.graphics-template":
        return .otg
    case "application/vnd.openxmlformats-officedocument.presentationml.slideshow":
        return .ppsx
    case "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet":
        return .xlsx
    case "application/vnd.ms-excel.sheet.macroenabled":
        return .xlsm
    case "application/vnd.ms-excel.sheet.macroenabled.12":
        return .xlsm
    case "application/vnd.openxmlformats-officedocument.spreadsheetml.template":
        return .xltx
    case "application/vnd.ms-excel.template.macroenabled":
        return .xltm
    case "application/vnd.ms-excel.template.macroenabled.12":
        return .xltm
    case "application/vnd.ms-powerpoint.slideshow.macroenabled":
        return .ppsm
    case "application/vnd.ms-powerpoint.slideshow.macroenabled.12":
        return .ppsm
    case "application/vnd.openxmlformats-officedocument.wordprocessingml.document":
        return .docx
    case "application/vnd.ms-word.document.macroenabled":
        return .docm
    case "application/vnd.ms-word.document.macroenabled.12":
        return .docm
    case "application/vnd.openxmlformats-officedocument.wordprocessingml.template":
        return .dotx
    case "application/vnd.ms-word.template.macroenabledtemplate":
        return .dotm
    case "application/vnd.ms-word.template.macroenabled.12":
        return .dotm
    case "application/vnd.openxmlformats-officedocument.presentationml.template":
        return .potx
    case "application/vnd.ms-powerpoint.template.macroenabled":
        return .potm
    case "application/vnd.ms-powerpoint.template.macroenabled.12":
        return .potm
    case "application/vnd.openxmlformats-officedocument.presentationml.presentation":
        return .pptx
    case "application/vnd.ms-powerpoint.presentation.macroenabled":
        return .pptm
    case "application/vnd.ms-powerpoint.presentation.macroenabled.12":
        return .pptm
    case "application/vnd.ms-visio.drawing":
        return .vsdx
    case "application/vnd.visio":
        return .vsdx
    case "application/vnd.ms-package.3dmanufacturing-3dmodel+xml":
        return .threemf
    default:
        return nil
    }
}

private func updateOpenXMLZipDetectionState(
    _ state: inout OpenXMLZipDetectionState,
    filename: String
) {
    if filename.hasPrefix("word/") {
        state.hasWordDirectory = true
    }

    if filename.hasPrefix("ppt/") {
        state.hasPresentationDirectory = true
    }

    if filename.hasPrefix("xl/") {
        state.hasSpreadsheetDirectory = true
    }

    if filename.hasPrefix("3D/"), filename.hasSuffix(".model") {
        state.hasThreeDimensionalModelEntry = true
    }
}

private func fallbackOpenXMLFileType(from state: OpenXMLZipDetectionState) -> FileTypeMatchType? {
    guard
        state.hasContentTypesEntry,
        !state.hasUnparseableContentTypes,
        !state.hasParsedContentTypesEntry
    else {
        if state.hasThreeDimensionalModelEntry {
            return .threemf
        }

        return nil
    }

    if state.hasWordDirectory {
        return .docx
    }

    if state.hasPresentationDirectory {
        return .pptx
    }

    if state.hasSpreadsheetDirectory {
        return .xlsx
    }

    if state.hasThreeDimensionalModelEntry {
        return .threemf
    }

    return nil
}

private func openXMLPackageMIMEType(from xmlContent: String) -> String? {
    let mainSuffix = ".main+xml\""
    let lowercasedContent = xmlContent.lowercased()

    if let endPosition = lowercasedContent.range(of: mainSuffix)?.lowerBound {
        let prefix = lowercasedContent[..<endPosition]
        let mainContentType: String
        if let lastQuote = prefix.lastIndex(of: "\"") {
            mainContentType = String(prefix[prefix.index(after: lastQuote)...])
        } else {
            mainContentType = String(prefix)
        }

        return mainContentType
    }

    let threeDimensionalModelMIMEType = "application/vnd.ms-package.3dmanufacturing-3dmodel+xml"
    if lowercasedContent.contains("contenttype=\"\(threeDimensionalModelMIMEType)\"") {
        return threeDimensionalModelMIMEType
    }

    return nil
}

private func isAndroidDexEntry(_ filename: String) -> Bool {
    guard filename.hasPrefix("classes"), filename.hasSuffix(".dex") else {
        return filename == "AndroidManifest.xml"
    }

    let index = filename.index(filename.startIndex, offsetBy: 7)
    let suffix = filename[index..<filename.index(filename.endIndex, offsetBy: -4)]
    return suffix.isEmpty || suffix.allSatisfy(\.isNumber)
}
