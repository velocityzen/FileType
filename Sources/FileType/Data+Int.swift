import Foundation

internal extension Data {
  func getInt16LE(offset: Int = 0) -> Int {
    return Int(
      UInt16(self[offset]) |
      (UInt16(self[offset + 1]) << 8)
    )
  }

  func getInt16BE(offset: Int = 0) -> Int {
    return Int(
      UInt16(self[offset]) << 8 |
      UInt16(self[offset + 1])
    )
  }

  func getInt32BE(offset: Int = 0) -> Int {
    return Int(
      (UInt32(self[offset]) << 24) |
      (UInt32(self[offset + 1]) << 16) |
      (UInt32(self[offset + 2]) << 8) |
      UInt32(self[offset + 3])
    )
  }

  func getInt32LE(offset: Int = 0) -> Int {
    return Int(
      (
        UInt32(self[offset]) |
        (UInt32(self[offset + 1]) << 8) |
        (UInt32(self[offset + 2]) << 16) |
        (UInt32(self[offset + 3]) << 24)
      )
    )
  }

  func getInt64BE(offset: Int = 0) -> Int {
    let number = (UInt64(self[offset]) << 32) |
                (UInt64(self[offset + 1]) << 24) |
                (UInt64(self[offset + 2]) << 16) |
                (UInt64(self[offset + 3]) << 8) |
                UInt64(self[offset + 4])

    return Int( number )
  }

  func getInt64LE(offset: Int = 0) -> Int {
    let number = UInt64(self[offset]) |
                (UInt64(self[offset + 1]) << 8) |
                (UInt64(self[offset + 2]) << 16) |
                (UInt64(self[offset + 3]) << 24) |
                (UInt64(self[offset + 4]) << 32)

    return Int( number )
  }

  /**
   ID3 UINT32 sync-safe tokenizer token.
   28 bits (representing up to 256MB) integer, the msb is 0 to avoid "false syncsignals".
   */
  func getUInt32SyncSafeToken(offset: Int = 0) -> Int {
    return Int(
      UInt32(self[offset + 3]) & 0x7F |
      UInt32(self[offset + 2]) << 7 |
      UInt32(self[offset + 1]) << 14 |
      UInt32(self[offset]) << 21
    )
  }
}
