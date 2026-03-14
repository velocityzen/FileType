import Foundation

func matchMatroskaDocType(_ data: Data, _ type: String) -> Bool {
    let searchUpperBound = min(data.count, 4096)
    guard searchUpperBound > 3 else {
        return false
    }

    guard let headerRange = data.firstRange(of: [0x42, 0x82], in: 3..<searchUpperBound) else {
        return false
    }

    let start = headerRange.upperBound + 1
    let end = headerRange.upperBound + 5
    let docType = data.getString(from: start..<end)

    return docType == type
}
