import Foundation

private let manifestTextEncodings: [String.Encoding] = [
    .utf8,
    .utf16LittleEndian,
    .utf16BigEndian,
]

private let manifestLeadingCharacters =
    CharacterSet.whitespacesAndNewlines.union(CharacterSet(charactersIn: "\u{FEFF}"))

func matchM3U(_ data: Data) -> Bool {
    guard
        let manifestText = manifestText(from: data)?
            .trimmingCharacters(in: manifestLeadingCharacters)
            .uppercased(),
        manifestText.hasPrefix("#EXTM3U")
    else {
        return false
    }

    // Require an HLS-specific tag so generic M3U playlists do not match.
    return manifestText.contains("#EXT-X-")
}

func matchMPD(_ data: Data) -> Bool {
    matchXMLManifest(data, rootElement: "MPD")
}

func matchISM(_ data: Data) -> Bool {
    matchXMLManifest(data, rootElement: "SmoothStreamingMedia")
}

private func matchXMLManifest(_ data: Data, rootElement: String) -> Bool {
    guard
        let manifestText = manifestText(from: data),
        let startTag = firstXMLStartTag(in: manifestText)
    else {
        return false
    }

    return startTag == rootElement
}

private func manifestText(from data: Data) -> String? {
    for encoding in manifestTextEncodings {
        if let manifestText = String(data: data, encoding: encoding) {
            return manifestText
        }
    }

    return nil
}

private func firstXMLStartTag(in text: String) -> String? {
    var remaining = text[...]

    while true {
        remaining = remaining.drop(while: isManifestLeadingCharacter)

        guard remaining.first == "<" else {
            return nil
        }

        if remaining.hasPrefix("<?") {
            guard let terminator = remaining.range(of: "?>") else {
                return nil
            }

            remaining = remaining[terminator.upperBound...]
            continue
        }

        if remaining.hasPrefix("<!--") {
            guard let terminator = remaining.range(of: "-->") else {
                return nil
            }

            remaining = remaining[terminator.upperBound...]
            continue
        }

        if remaining.hasPrefix("<!") {
            guard let terminator = remaining.firstIndex(of: ">") else {
                return nil
            }

            remaining = remaining[remaining.index(after: terminator)...]
            continue
        }

        let rawTagName =
            remaining
            .dropFirst()
            .prefix { character in
                !character.isWhitespace && character != ">" && character != "/"
            }

        guard !rawTagName.isEmpty else {
            return nil
        }

        return String(rawTagName.split(separator: ":").last ?? rawTagName[...])
    }
}

private func isManifestLeadingCharacter(_ character: Character) -> Bool {
    character.unicodeScalars.allSatisfy(manifestLeadingCharacters.contains)
}
