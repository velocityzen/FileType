import Foundation

extension Data {
  var hexDescription: String {
    return reduce("") {$0 + String(format: "%02x", $1)}
  }
}

internal func matchAsfHeader(_ data: Data, _ match: [UInt8]) -> Bool {
  var position = 30
  
  while position + 24 < data.count {
    let id = data[position..<position+16]
    let size = data.getInt64LE(offset: position+16)
    var payloadSize = size - 24
    
    position += 24
      
    // Sync on Stream-Properties-Object (B7DC0791-A9B7-11CF-8EE6-00C00C205365)
    if id.starts(with: [0x91, 0x07, 0xDC, 0xB7, 0xB7, 0xA9, 0xCF, 0x11, 0x8E, 0xE6, 0x00, 0xC0, 0x0C, 0x20, 0x53, 0x65]) {
      
      let typeId = data[position..<position+16]
      payloadSize -= typeId.count
      
      if typeId.starts(with: match) {
        return true
      } else {
        break
      }
    }
    
    position += payloadSize
  }
  
  return false
}
