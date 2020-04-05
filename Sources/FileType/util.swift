import Foundation

internal func readUInt32Safe(_ data: Data, offset: Int) -> Int {
  return Int(data[offset + 3] & 0x7F | data[offset + 2] << 7 | data[offset + 1] << 14 | data[offset] << 21)
}

internal func skipID3Header(_ data: Data) -> Data? {
  let id3HeaderOffset = 6
  let id3HeaderSize = readUInt32Safe(data, offset: id3HeaderOffset) + id3HeaderOffset
  if (id3HeaderSize > data.count) {
    return nil
  }
  
  return data.advanced(by: id3HeaderSize)
}

enum MatchPattern {
  case byte(UInt8)
  case any
}

internal func matchPatterns(_ data: Data, match: [[MatchPattern]], offset: Int = 0, mask: [UInt8]? = nil) -> Bool {
  for m in match {
    var matched = true
    
    loop: for (index, pattern) in m.enumerated() {
      switch pattern {
        case .byte(let byte):
          if (mask != nil) {
            if (data[offset + index] & mask![index]) != byte {
              matched = false
              break loop
            }
          } else if data[offset + index] != byte {
            matched = false
            break loop
          }
        
        case .any:
          continue
      }
    }
    
    if (matched) {
      return true
    }
  }
  
  return false
}

internal func findString(_ data: Data, _ string: String, ignore: Int? = nil) -> Bool {
  let minRange = min(data.count, ignore ?? data.count)
  let pattern = string.data(using: .utf8)!
  return data.range(of: pattern, in: minRange..<data.count) != nil
}
