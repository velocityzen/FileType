import Foundation

enum MatchPattern {
  case byte(UInt8)
  case any
}

func matchPatterns(_ data: Data, match: [[MatchPattern]], offset: Int = 0, mask: [UInt8]? = nil) -> Bool {
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

func findString(_ data: Data, _ string: String, ignore: Int? = nil) -> Bool {
  let minRange = min(data.count, ignore ?? data.count)
  let pattern = string.data(using: .utf8)!
  return data.range(of: pattern, in: minRange..<data.count) != nil
}
