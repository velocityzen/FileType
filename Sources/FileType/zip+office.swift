import Foundation

struct ZipHeader {
  let filename: String
  var mimeType: String? = nil
}

func matchZipHeader(_ data: Data, _ match: (ZipHeader) -> Bool) -> Bool {
  var position: Int = 0
  while (position + 30 < data.count) {
    let compressedSize = data.getInt32LE(offset: position + 18)
    let uncompressedSize = data.getInt32LE(offset: position + 22)
    let filenameLength = data.getInt16LE(offset: position + 26)
    guard let filename = data.getUTF8String(from: position + 30..<position + 30 + filenameLength) else {
      return false
    }
    
    var zipHeader = ZipHeader(
      filename: filename
    )
    
    let extraFieldLength = data.getInt16LE(offset: position + 28)
    position += 30 + filenameLength + extraFieldLength
    
    if zipHeader.filename == "mimetype" && compressedSize == uncompressedSize {
      zipHeader.mimeType = data.getUTF8String(from: position..<position + compressedSize)
    }
  
    if (match(zipHeader)) {
      return true
    }
    
    position += compressedSize
  }
  
  return false
}

func matchMSOffice(_ header: ZipHeader, type: String, startsWith: String? = nil) -> Bool {
  guard header.filename.count > 4 else {
    return false
  }
  
  if startsWith != nil && header.filename.starts(with: startsWith!) {
    return true
  }
    
  guard header.filename.hasSuffix(".rels") || header.filename.hasSuffix(".xml") else {
    return false
  }
  
  return header.filename.split(separator: "/")[0] == type
}
