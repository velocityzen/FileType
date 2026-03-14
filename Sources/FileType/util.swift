import Foundation

enum MatchPattern {
    case byte(UInt8)
    case any
}

func matchPatterns(_ data: Data, match: [[MatchPattern]], offset: Int = 0, mask: [UInt8]? = nil)
    -> Bool
{
    for m in match {
        if let mask, mask.count < m.count {
            return false
        }

        guard data.hasBytes(in: offset..<offset + m.count) else {
            continue
        }

        var matched = true

        loop: for (index, pattern) in m.enumerated() {
            switch pattern {
            case .byte(let byte):
                if let mask {
                    if (data[offset + index] & mask[index]) != byte {
                        matched = false
                        break loop
                    }
                } else if data[offset + index] != byte {
                    matched = false
                    break loop
                }

            case .any:
                continue
            }
        }

        if matched {
            return true
        }
    }

    return false
}

func findString(_ data: Data, _ string: String, ignore: Int? = nil) -> Bool {
    let minimumOffset = min(data.count, max(0, ignore ?? 0))
    let pattern = Data(string.utf8)
    return data.range(of: pattern, in: minimumOffset..<data.count) != nil
}
