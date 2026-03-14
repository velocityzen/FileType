import Foundation

private enum TIFFByteOrder {
    case littleEndian
    case bigEndian
}

private let maximumTIFFTagCount = 512

func detectTIFFFileType(_ data: Data) -> FileTypeMatchType? {
    let byteOrder: TIFFByteOrder
    if data.starts(with: [0x49, 0x49]) {
        byteOrder = .littleEndian
    } else if data.starts(with: [0x4D, 0x4D]) {
        byteOrder = .bigEndian
    } else {
        return nil
    }

    let version = readTIFFUInt16(data, byteOrder: byteOrder, offset: 2)
    guard let version else {
        return nil
    }

    if version == 43 {
        return .tif
    }

    guard version == 42 else {
        return nil
    }

    if byteOrder == .littleEndian {
        if data.getString(from: 8..<10, encoding: .ascii) == "CR" {
            return .cr2
        }

        let someId1 = data.getUInt16LE(offset: 8)
        let someId2 = data.getUInt16LE(offset: 10)
        if (someId1 == 0x001C && someId2 == 0x00FE) || (someId1 == 0x001F && someId2 == 0x000B) {
            return .nef
        }
    }

    guard
        let ifdOffsetValue = readTIFFUInt32(data, byteOrder: byteOrder, offset: 4),
        let ifdOffset = Int(exactly: ifdOffsetValue),
        ifdOffset >= 8,
        data.hasBytes(in: ifdOffset..<ifdOffset + 2),
        let tagCountValue = readTIFFUInt16(data, byteOrder: byteOrder, offset: ifdOffset)
    else {
        return .tif
    }

    let tagCount = min(Int(tagCountValue), maximumTIFFTagCount)
    var tagOffset = ifdOffset + 2

    for _ in 0..<tagCount {
        guard data.hasBytes(in: tagOffset..<tagOffset + 12) else {
            break
        }

        let tagIdentifier = readTIFFUInt16(data, byteOrder: byteOrder, offset: tagOffset)
        switch tagIdentifier {
        case 50_341:
            return .arw
        case 50_706:
            return .dng
        default:
            break
        }

        tagOffset += 12
    }

    return .tif
}

private func readTIFFUInt16(_ data: Data, byteOrder: TIFFByteOrder, offset: Int) -> UInt16? {
    switch byteOrder {
    case .littleEndian:
        return data.getUInt16LE(offset: offset)
    case .bigEndian:
        return data.getUInt16BE(offset: offset)
    }
}

private func readTIFFUInt32(_ data: Data, byteOrder: TIFFByteOrder, offset: Int) -> UInt32? {
    switch byteOrder {
    case .littleEndian:
        return data.getUInt32LE(offset: offset)
    case .bigEndian:
        return data.getUInt32BE(offset: offset)
    }
}
