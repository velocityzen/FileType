import Foundation

internal extension Data {
  func getString(from range: Range<Int>, encoding: String.Encoding = .utf8) -> String? {
    guard range.endIndex <= count else {
      return nil
    }
    return String(data: self[range], encoding: encoding)
  }

  func getIntByteString(from range: Range<Int>) -> Int? {
    guard let octal = String(data: self[range], encoding: .utf8) else {
      return nil
    }

    return Int(octal, radix: 0o10)
  }
}
