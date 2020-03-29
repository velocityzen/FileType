import Foundation

public func getBytesCountForType(_ type: FileTypeExtension) -> Int {
  return FileType.all
    .filter { $0.type == type }
    .reduce(into: 0) { $0 = max(
      $0,
      $1.bytesCount ?? 0,
      $1.matchBytes?.reduce(into: 0) { $0 = max($0, $1.count) } ?? 0,
      $1.matchString?.reduce(into: 0) { $0 = max($0, $1.count) } ?? 0
    )}
}

public func getBytesCountForTypes(_ types: [FileTypeExtension]) -> Int {
  return FileType.all
    .filter { types.contains($0.type) }
    .reduce(into: 0) { $0 = max(
      $0,
      $1.bytesCount ?? 0,
      $1.matchBytes?.reduce(into: 0) { $0 = max($0, $1.count) } ?? 0,
      $1.matchString?.reduce(into: 0) { $0 = max($0, $1.count) } ?? 0
      )}
}

public func getFileType(from data: Data) -> FileType? {
  for fileType in FileType.all {
    if fileType.bytesCount != nil && fileType.bytesCount! > data.count {
      continue
    }
        
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
    
    if let match = fileType.match {
      if (match(data)) {
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
