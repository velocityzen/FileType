import Foundation

func matchACE(_ data: Data) -> Bool {
    data.getString(from: 7..<12, encoding: .ascii) == "**ACE"
        && data.getString(from: 12..<14, encoding: .ascii) == "**"
}
