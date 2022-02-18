import Foundation

func findAPNG(_ data: Data) -> Bool {
  // Offset calculated as follows:
  // - 8 bytes: PNG signature
  // - 4 (length) + 4 (chunk type) + 13 (chunk data) + 4 (CRC): IHDR chunk
  var position = 8 // ignore PNG signature

  repeat {
    let length = data.getInt32BE(offset: position)
    let type = data.getString(from: (position + 4) ..< (position + 8))!

    if length < 0 {
      return false
    }

    switch type {
      case "acTL":
        return true

      case "IDAT":
        return false

      default:
        position += 8 + length + 4 // Ignore chunk-data + CRC
    }

  } while position < data.count

  return false
}
