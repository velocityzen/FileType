import Foundation

func matchMatroskaDocType(_ data: Data, _ type: String) -> Bool {
  guard let headerRange = data.firstRange(of: [0x42, 0x82], in: 3..<4096) else {
    return false
  }
  
  let start = headerRange.upperBound + 1;
  let end = headerRange.upperBound + 5;
  let docType = data.getString(from: start ..< end)

  return docType == type
}
