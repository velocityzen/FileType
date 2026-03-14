import Foundation

func matchMPEGHeader(_ data: Data, match: UInt8, mask: UInt8) -> Bool {
    guard data.hasBytes(in: 0..<2) else {
        return false
    }

    return (data[0] & 0xFF) == 0xFF && (data[1] & 0xE0) == 0xE0 && data[1] & mask == match
}

func dataByStrippingID3Header(_ data: Data) -> Data? {
    guard
        data.starts(with: Data("ID3".utf8)),
        let byte0 = data.byte(at: 6),
        let byte1 = data.byte(at: 7),
        let byte2 = data.byte(at: 8),
        let byte3 = data.byte(at: 9)
    else {
        return nil
    }

    let payloadSize =
        (Int(byte0) << 21) | (Int(byte1) << 14) | (Int(byte2) << 7) | Int(byte3)
    let headerSize = 10
    let totalSize = headerSize + payloadSize

    guard totalSize > headerSize, totalSize <= data.count else {
        return nil
    }

    return data.subdata(in: totalSize..<data.count)
}
