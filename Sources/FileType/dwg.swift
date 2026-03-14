import Foundation

func matchDWG(_ data: Data) -> Bool {
    guard
        data.getString(from: 0..<2, encoding: .ascii) == "AC",
        let versionString = data.getString(from: 2..<6, encoding: .ascii),
        let version = Int(versionString),
        (1000...1050).contains(version)
    else {
        return false
    }

    return true
}
