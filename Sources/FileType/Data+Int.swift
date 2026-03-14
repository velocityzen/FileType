import Foundation

extension Data {
    func hasBytes(in range: Range<Int>) -> Bool {
        range.lowerBound >= 0 && range.upperBound <= count
    }

    func byte(at offset: Int) -> UInt8? {
        guard hasBytes(in: offset..<offset + 1) else {
            return nil
        }

        return self[offset]
    }

    func getUInt16LE(offset: Int = 0) -> UInt16? {
        guard
            let byte0 = byte(at: offset),
            let byte1 = byte(at: offset + 1)
        else {
            return nil
        }

        return UInt16(byte0) | (UInt16(byte1) << 8)
    }

    func getInt16LE(offset: Int = 0) -> Int? {
        getUInt16LE(offset: offset).map(Int.init)
    }

    func getUInt16BE(offset: Int = 0) -> UInt16? {
        guard
            let byte0 = byte(at: offset),
            let byte1 = byte(at: offset + 1)
        else {
            return nil
        }

        return (UInt16(byte0) << 8) | UInt16(byte1)
    }

    func getInt16BE(offset: Int = 0) -> Int? {
        getUInt16BE(offset: offset).map(Int.init)
    }

    func getUInt32BE(offset: Int = 0) -> UInt32? {
        guard
            let byte0 = byte(at: offset),
            let byte1 = byte(at: offset + 1),
            let byte2 = byte(at: offset + 2),
            let byte3 = byte(at: offset + 3)
        else {
            return nil
        }

        return (UInt32(byte0) << 24) | (UInt32(byte1) << 16) | (UInt32(byte2) << 8) | UInt32(byte3)
    }

    func getInt32BE(offset: Int = 0) -> Int? {
        getUInt32BE(offset: offset).map(Int.init)
    }

    func getUInt32LE(offset: Int = 0) -> UInt32? {
        guard
            let byte0 = byte(at: offset),
            let byte1 = byte(at: offset + 1),
            let byte2 = byte(at: offset + 2),
            let byte3 = byte(at: offset + 3)
        else {
            return nil
        }

        return UInt32(byte0) | (UInt32(byte1) << 8) | (UInt32(byte2) << 16) | (UInt32(byte3) << 24)
    }

    func getInt32LE(offset: Int = 0) -> Int? {
        getUInt32LE(offset: offset).map(Int.init)
    }

    func getUInt64BE(offset: Int = 0) -> UInt64? {
        guard
            let byte0 = byte(at: offset),
            let byte1 = byte(at: offset + 1),
            let byte2 = byte(at: offset + 2),
            let byte3 = byte(at: offset + 3),
            let byte4 = byte(at: offset + 4),
            let byte5 = byte(at: offset + 5),
            let byte6 = byte(at: offset + 6),
            let byte7 = byte(at: offset + 7)
        else {
            return nil
        }

        return (UInt64(byte0) << 56) | (UInt64(byte1) << 48) | (UInt64(byte2) << 40)
            | (UInt64(byte3) << 32) | (UInt64(byte4) << 24) | (UInt64(byte5) << 16)
            | (UInt64(byte6) << 8) | UInt64(byte7)
    }

    func getInt64BE(offset: Int = 0) -> Int? {
        guard let value = getUInt64BE(offset: offset), value <= UInt64(Int.max) else {
            return nil
        }

        return Int(value)
    }

    func getUInt64LE(offset: Int = 0) -> UInt64? {
        guard
            let byte0 = byte(at: offset),
            let byte1 = byte(at: offset + 1),
            let byte2 = byte(at: offset + 2),
            let byte3 = byte(at: offset + 3),
            let byte4 = byte(at: offset + 4),
            let byte5 = byte(at: offset + 5),
            let byte6 = byte(at: offset + 6),
            let byte7 = byte(at: offset + 7)
        else {
            return nil
        }

        return UInt64(byte0) | (UInt64(byte1) << 8) | (UInt64(byte2) << 16) | (UInt64(byte3) << 24)
            | (UInt64(byte4) << 32) | (UInt64(byte5) << 40) | (UInt64(byte6) << 48)
            | (UInt64(byte7) << 56)
    }

    func getInt64LE(offset: Int = 0) -> Int? {
        guard let value = getUInt64LE(offset: offset), value <= UInt64(Int.max) else {
            return nil
        }

        return Int(value)
    }
}
