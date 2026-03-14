import Foundation

func matchVTT(_ data: Data) -> Bool {
    guard data.starts(with: Data("WEBVTT".utf8)) else {
        return false
    }

    guard let nextByte = data.byte(at: 6) else {
        return true
    }

    return [0x0A, 0x0D, 0x09, 0x20, 0x00].contains(nextByte)
}
