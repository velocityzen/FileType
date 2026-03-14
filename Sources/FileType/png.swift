import Foundation

private enum PNG {
    case corrupt
    case png
    case apng
}

private func checkPNG(_ data: Data) -> PNG {
    guard data.hasBytes(in: 0..<8) else {
        return .corrupt
    }

    // Offset calculated as follows:
    // - 8 bytes: PNG signature
    // - 4 (length) + 4 (chunk type) + 13 (chunk data) + 4 (CRC): IHDR chunk
    var position = 8  // ignore PNG signature

    while data.hasBytes(in: position..<position + 8) {
        guard
            let length = data.getUInt32BE(offset: position),
            let type = data.getString(from: (position + 4)..<(position + 8), encoding: .ascii)
        else {
            return .corrupt
        }

        switch type {
        case "acTL":
            return .apng

        case "IDAT":
            return .png

        default:
            let nextPosition = UInt64(position) + 8 + UInt64(length) + 4
            guard nextPosition <= UInt64(data.count) else {
                return .corrupt
            }

            position = Int(nextPosition)  // Ignore chunk-data + CRC
        }
    }

    return .corrupt
}

func findAPNG(_ data: Data) -> Bool {
    let png = checkPNG(data)
    return png == .apng
}

func findPNG(_ data: Data) -> Bool {
    let png = checkPNG(data)
    return png == .png
}
