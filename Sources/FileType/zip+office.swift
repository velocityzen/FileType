import Foundation

internal struct ZipHeader {
  let filename: String
  let compressedSize: Int
  let uncompressedSize: Int
  var mimeType: String? = nil
}

internal func matchZipHeader(_ data: Data, _ match: (ZipHeader) -> Bool) -> Bool {
  var position: Int = 0
  while (position + 30 < data.count) {
    let filenameLength = data.getInt16LE(offset: position + 26)
    guard let filename = data.getUTF8String(from: position + 30..<position + 30 + filenameLength) else {
      return false
    }
    
    var zipHeader = ZipHeader(
      filename: filename,
      compressedSize: data.getInt32LE(offset: position + 18),
      uncompressedSize: data.getInt32LE(offset: position + 22)
    )
    
    let extraFieldLength = data.getInt16LE(offset: position + 28)
    position += 30 + filenameLength + extraFieldLength
    
    if zipHeader.filename == "mimetype" &&
      zipHeader.compressedSize == zipHeader.uncompressedSize {
      zipHeader.mimeType = data.getUTF8String(from: position..<position + zipHeader.compressedSize)
    }
  
    if (match(zipHeader)) {
      return true
    }
    
    position += zipHeader.compressedSize
  }
  
  return false
}

internal func matchMSOffice(_ header: ZipHeader, type: String, startsWith: String? = nil) -> Bool {
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
