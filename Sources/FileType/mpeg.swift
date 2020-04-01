import Foundation

internal func matchMPEGHeader(_ data: Data, match: UInt8, mask: UInt8) -> Bool {
  for i in 0...1 {
    if (data[i] & 0xFF) == 0xFF && (data[i + 1] & 0xE0) == 0xE0 {
      return data[i + 1] & mask == match
    }
  }
  
  return false
}
