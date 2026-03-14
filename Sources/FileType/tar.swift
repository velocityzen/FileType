import Foundation

func tarHeaderChecksumMatches(_ data: Data) -> Bool {
    guard
        data.count >= 512,
        let checksumField = String(data: data[148..<156], encoding: .ascii)
    else {
        return false
    }

    let checksumString =
        checksumField
        .split(separator: "\0", maxSplits: 1, omittingEmptySubsequences: false)
        .first?
        .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

    guard let readSum = Int(checksumString, radix: 8) else {
        return false
    }

    var sum = 8 * 0x20

    for index in 0..<148 {
        sum += Int(data[index])
    }

    for index in 156..<512 {
        sum += Int(data[index])
    }

    return readSum == sum
}
