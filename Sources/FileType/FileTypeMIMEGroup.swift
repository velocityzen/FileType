public enum FileTypeMIMEGroup: String, CaseIterable, Sendable {
    case application
    case audio
    case font
    case image
    case model
    case text
    case video

    init?(mime: String) {
        guard let separatorIndex = mime.firstIndex(of: "/") else {
            return nil
        }

        let majorType = String(mime[..<separatorIndex])
        self.init(rawValue: majorType)
    }
}

extension FileType {
    public var mimeGroup: FileTypeMIMEGroup {
        guard let mimeGroup = FileTypeMIMEGroup(mime: mime) else {
            preconditionFailure("Unsupported MIME type: \(mime)")
        }

        return mimeGroup
    }
}
