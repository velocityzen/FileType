import Foundation

func matchAsfHeader(_ data: Data, _ match: [UInt8]) -> Bool {
    var position = 30

    while data.hasBytes(in: position..<position + 24) {
        let id = data[position..<position + 16]
        guard let size = data.getUInt64LE(offset: position + 16), size >= 24 else {
            return false
        }

        position += 24

        // Sync on Stream-Properties-Object (B7DC0791-A9B7-11CF-8EE6-00C00C205365)
        if id.starts(with: [
            0x91, 0x07, 0xDC, 0xB7, 0xB7, 0xA9, 0xCF, 0x11, 0x8E, 0xE6, 0x00, 0xC0, 0x0C, 0x20,
            0x53, 0x65,
        ]) {
            guard data.hasBytes(in: position..<position + 16) else {
                return false
            }

            let typeId = data[position..<position + 16]

            if typeId.starts(with: match) {
                return true
            } else {
                break
            }
        }

        let payloadSize = Int(size - 24)
        guard payloadSize <= data.count - position else {
            return false
        }

        position += payloadSize
    }

    return false
}
