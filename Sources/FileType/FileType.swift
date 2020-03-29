import Foundation

private func read(data: Data, count: Int) -> [UInt8] {
  var bytes = [UInt8](repeating: 0, count: count)
  data.copyBytes(to: &bytes, count: count)
  
  return bytes
}

func getFileType(from data: Data) -> FileType? {
  for fileType in FileType.all {
    var isMatched: Bool = false
    
    if let matchString = fileType.matchString {
      if (matchString.contains(where: { data.starts(with: $0.utf8) })) {
        isMatched = true
      } else {
        continue
      }
    }
    
    if let matchBytes = fileType.matchBytes {
      if (matchBytes.contains(where: { data.starts(with: $0) })) {
        isMatched = true
      } else {
        continue
      }
    }
    
    if (isMatched) {
      return fileType
    }
  }
  
  return nil
}
