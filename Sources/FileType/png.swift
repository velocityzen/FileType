import Foundation

private enum PNG {
  case Corrupt
  case PNG
  case APNG
}

private func checkPNG(_ data: Data) -> PNG {
  // Offset calculated as follows:
  // - 8 bytes: PNG signature
  // - 4 (length) + 4 (chunk type) + 13 (chunk data) + 4 (CRC): IHDR chunk
  var position = 8 // ignore PNG signature

  repeat {
    let length = data.getInt32BE(offset: position)
    let type = data.getString(from: (position + 4) ..< (position + 8))!

    if length < 0 {
      return .Corrupt
    }

    switch type {
      case "acTL":
        return .APNG

      case "IDAT":
        return .PNG

      default:
        position += 8 + length + 4 // Ignore chunk-data + CRC
    }

  } while position < data.count

  return .PNG
}

func findAPNG(_ data: Data) -> Bool {
  let png = checkPNG(data)
  return png == .APNG
}

func findPNG(_ data: Data) -> Bool {
  let png = checkPNG(data)
  return png == .PNG
}
