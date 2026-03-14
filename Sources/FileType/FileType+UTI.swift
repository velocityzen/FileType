#if canImport(UniformTypeIdentifiers)
import UniformTypeIdentifiers

@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, visionOS 1.0, *)
extension FileType {
    private static let fileTypesByMIME: [String: [FileType]] = {
        Dictionary(grouping: FileType.all.values, by: \.mime)
    }()

    /// Detect a file type from a Uniform Type Identifier string.
    ///
    /// Uses the system's `UTType` to resolve the MIME type and file extension,
    /// then matches against known file types.
    ///
    /// - Parameter identifier: A UTI identifier string (e.g. `"public.jpeg"`,
    ///   `"com.adobe.pdf"`).
    /// - Returns: The matching `FileType`, or `nil` if no match is found.
    public static func detect(uti identifier: String) -> FileType? {
        guard let utType = UTType(identifier) else {
            return nil
        }

        return detect(utType: utType)
    }

    /// Detect a file type from a `UTType`.
    ///
    /// - Parameter utType: A `UTType` value.
    /// - Returns: The matching `FileType`, or `nil` if no match is found.
    public static func detect(utType: UTType) -> FileType? {
        let ext = utType.preferredFilenameExtension
        let mime = utType.preferredMIMEType

        // Try MIME match, preferring the candidate whose extension matches
        if let mime, let candidates = fileTypesByMIME[mime] {
            if let ext, let match = candidates.first(where: { $0.ext == ext }) {
                return match
            }

            return candidates.first
        }

        // Fall back to extension-only lookup
        if let ext {
            for fileType in FileType.all.values where fileType.ext == ext {
                return fileType
            }
        }

        return nil
    }
}
#endif
