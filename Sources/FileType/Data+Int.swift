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
  
  func getUTF8String(from range: Range<Int>) -> String? {
    guard range.endIndex <= self.count else {
      return nil
    }
    return String(data: self[range], encoding: .utf8)
  }
  
  func getIntByteString(from range: Range<Int>) -> Int? {
    guard let octal = String(data: self[range], encoding: .utf8) else {
      return nil
    }
    
    return Int(octal, radix: 0o10)
  }
}
