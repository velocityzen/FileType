import Foundation
import Testing

@testable import FileType

struct DetectionCase: Sendable, CustomStringConvertible {
    let fixtureName: String
    let expectedType: FileTypeExtension

    var description: String {
        "\(fixtureName) -> \(expectedType)"
    }
}

private let testFileURL = URL(fileURLWithPath: #filePath)
private let fixturesDirectory =
    testFileURL
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .appending(path: "Fixtures", directoryHint: .isDirectory)

private let specialDetectionCases: [DetectionCase] = [
    DetectionCase(fixtureName: "fixture-v7.tar", expectedType: .tar),
    DetectionCase(fixtureName: "fixture-spaces.tar", expectedType: .tar),
    DetectionCase(fixtureName: "fixture.tar.Z", expectedType: .Z),
    DetectionCase(fixtureName: "fixture.tar.gz", expectedType: .gz),
    DetectionCase(fixtureName: "fixture.tar.lz", expectedType: .lz),
    DetectionCase(fixtureName: "fixture.tar.xz", expectedType: .xz),
    DetectionCase(fixtureName: "fixture-sv7.mpc", expectedType: .mpc),
    DetectionCase(fixtureName: "fixture-sv8.mpc", expectedType: .mpc),
    DetectionCase(fixtureName: "fixture-big-endian.tif", expectedType: .tif),
    DetectionCase(fixtureName: "fixture-bali.tif", expectedType: .tif),
    DetectionCase(fixtureName: "fixture-little-endian.tif", expectedType: .tif),
    DetectionCase(fixtureName: "fixture-monkeysaudio.ape", expectedType: .ape),
    DetectionCase(fixtureName: "fixture-big-endian.mie", expectedType: .mie),
    DetectionCase(fixtureName: "fixture-little-endian.mie", expectedType: .mie),
    DetectionCase(fixtureName: "fixture2.nef", expectedType: .nef),
    DetectionCase(fixtureName: "fixture3.nef", expectedType: .nef),
    DetectionCase(fixtureName: "fixture4.nef", expectedType: .nef),
    DetectionCase(fixtureName: "fixture2.dng", expectedType: .dng),
    DetectionCase(fixtureName: "fixture2.arw", expectedType: .arw),
    DetectionCase(fixtureName: "fixture3.arw", expectedType: .arw),
    DetectionCase(fixtureName: "fixture4.arw", expectedType: .arw),
    DetectionCase(fixtureName: "fixture5.arw", expectedType: .arw),
    DetectionCase(fixtureName: "fixture-unknown-ogg.ogx", expectedType: .ogx),
    DetectionCase(fixtureName: "fixture-otto.woff", expectedType: .woff),
    DetectionCase(fixtureName: "fixture-otto.woff2", expectedType: .woff2),
    DetectionCase(fixtureName: "fixture-mjpeg.mov", expectedType: .mov),
    DetectionCase(fixtureName: "fixture-moov.mov", expectedType: .mov),
    DetectionCase(fixtureName: "fixture-yuv420-8bit.avif", expectedType: .avif),
    DetectionCase(fixtureName: "fixture-sequence.avif", expectedType: .avif),
    DetectionCase(fixtureName: "fixture-mif1.heic", expectedType: .heic),
    DetectionCase(fixtureName: "fixture-msf1.heic", expectedType: .heic),
    DetectionCase(fixtureName: "fixture-heic.heic", expectedType: .heic),
    DetectionCase(fixtureName: "fixture2.3gp", expectedType: .threegp),
    DetectionCase(fixtureName: "fixture-imovie.mp4", expectedType: .mp4),
    DetectionCase(fixtureName: "fixture-isom.mp4", expectedType: .mp4),
    DetectionCase(fixtureName: "fixture-isomv2.mp4", expectedType: .mp4),
    DetectionCase(fixtureName: "fixture-mp4v2.mp4", expectedType: .mp4),
    DetectionCase(fixtureName: "fixture-dash.mp4", expectedType: .mp4),
    DetectionCase(fixtureName: "fixture2.mpg", expectedType: .mpg),
    DetectionCase(fixtureName: "fixture.ps.mpg", expectedType: .mpg),
    DetectionCase(fixtureName: "fixture.sub.mpg", expectedType: .mpg),
    DetectionCase(fixtureName: "fixture-itxt.png", expectedType: .png),
    DetectionCase(fixtureName: "fixture-0x20001.eot", expectedType: .eot),
    DetectionCase(fixtureName: "fixture-adts-mpeg2.aac", expectedType: .aac),
    DetectionCase(fixtureName: "fixture-adts-mpeg4.aac", expectedType: .aac),
    DetectionCase(fixtureName: "fixture-adts-mpeg4-2.aac", expectedType: .aac),
    DetectionCase(fixtureName: "fixture-id3v2.aac", expectedType: .aac),
    DetectionCase(fixtureName: "fixture-id3v2.flac", expectedType: .flac),
    DetectionCase(fixtureName: "fixture-mp2l3.mp3", expectedType: .mp3),
    DetectionCase(fixtureName: "fixture-ffe3.mp3", expectedType: .mp3),
    DetectionCase(fixtureName: "fixture-mpa.mp2", expectedType: .mp2),
    DetectionCase(fixtureName: "fixture-office365.docx", expectedType: .docx),
    DetectionCase(fixtureName: "fixture-office365.pptx", expectedType: .pptx),
    DetectionCase(fixtureName: "fixture-office365.xlsx", expectedType: .xlsx),
    DetectionCase(fixtureName: "fixture2.docx", expectedType: .docx),
    DetectionCase(fixtureName: "fixture2.pptx", expectedType: .pptx),
    DetectionCase(fixtureName: "fixture2.xlsx", expectedType: .xlsx),
    DetectionCase(fixtureName: "fixture2.eps", expectedType: .eps),
    DetectionCase(fixtureName: "fixture-utf8-bom.xml", expectedType: .xml),
    DetectionCase(fixtureName: "fixture-utf16-be-bom.xml", expectedType: .xml),
    DetectionCase(fixtureName: "fixture-utf16-le-bom.xml", expectedType: .xml),
    DetectionCase(fixtureName: "fixture-raw.mts", expectedType: .mts),
    DetectionCase(fixtureName: "fixture-bdav.mts", expectedType: .mts),
    DetectionCase(fixtureName: "fixture.wma.asf", expectedType: .asf),
    DetectionCase(fixtureName: "fixture.wmv.asf", expectedType: .asf),
    DetectionCase(fixtureName: "fixture2.jxl", expectedType: .jxl),
    DetectionCase(fixtureName: "fixture.msi.cfb", expectedType: .cfb),
    DetectionCase(fixtureName: "fixture.xls.cfb", expectedType: .cfb),
    DetectionCase(fixtureName: "fixture.doc.cfb", expectedType: .cfb),
    DetectionCase(fixtureName: "fixture.ppt.cfb", expectedType: .cfb),
    DetectionCase(fixtureName: "fixture-2.doc.cfb", expectedType: .cfb),
    DetectionCase(fixtureName: "fixture.msi", expectedType: .cfb),
    DetectionCase(fixtureName: "fixture-doc.msi", expectedType: .cfb),
    DetectionCase(fixtureName: "fixture-ppt.msi", expectedType: .cfb),
    DetectionCase(fixtureName: "fixture-xls.msi", expectedType: .cfb),
    DetectionCase(fixtureName: "fixture-password-protected.xls", expectedType: .cfb),
    DetectionCase(fixtureName: "fixture2.mkv", expectedType: .mkv),
    DetectionCase(fixtureName: "fixture-corrupt.mkv", expectedType: .mkv),
    DetectionCase(fixtureName: "fixture-null.webm", expectedType: .webm),
    DetectionCase(fixtureName: "fixture-without-pdf-compatibility.ai", expectedType: .ai),
    DetectionCase(fixtureName: "fixture-adobe-illustrator.pdf", expectedType: .pdf),
    DetectionCase(fixtureName: "fixture-smallest.pdf", expectedType: .pdf),
    DetectionCase(fixtureName: "fixture-fast-web.pdf", expectedType: .pdf),
    DetectionCase(fixtureName: "fixture-printed.pdf", expectedType: .pdf),
    DetectionCase(fixtureName: "fixture-crlf.epub", expectedType: .epub),
    DetectionCase(fixtureName: "fixture-Leica-M10.dng", expectedType: .dng),
    DetectionCase(fixtureName: "fixture-sony-zv-e10.arw", expectedType: .arw),
    DetectionCase(fixtureName: "fixture-2.m4v", expectedType: .m4v),
    DetectionCase(fixtureName: "fixture-babys-songbook.m4b.m4a", expectedType: .m4a),
    DetectionCase(fixtureName: "fixture-pax.tar", expectedType: .tar),
    DetectionCase(fixtureName: "fixture.tar.zst", expectedType: .zst),
    DetectionCase(fixtureName: "fixture-minimal.pdf", expectedType: .pdf),
    DetectionCase(fixtureName: "fixture-big-endian.pcap", expectedType: .pcap),
    DetectionCase(fixtureName: "fixture-little-endian.pcap", expectedType: .pcap),
    DetectionCase(fixtureName: "fixture-normal.jls", expectedType: .jls),
    DetectionCase(fixtureName: "fixture-hp1.jls", expectedType: .jls),
    DetectionCase(fixtureName: "fixture-hp2.jls", expectedType: .jls),
    DetectionCase(fixtureName: "fixture-hp3.jls", expectedType: .jls),
    DetectionCase(fixtureName: "fixture-ascii.cpio", expectedType: .cpio),
    DetectionCase(fixtureName: "fixture-bin.cpio", expectedType: .cpio),
    DetectionCase(fixtureName: "fixture-vsdx.vsdx", expectedType: .vsdx),
    DetectionCase(fixtureName: "fixture-vstx.vsdx", expectedType: .vsdx),
    DetectionCase(fixtureName: "fixture-vtt-linebreak.vtt", expectedType: .vtt),
    DetectionCase(fixtureName: "fixture-vtt-space.vtt", expectedType: .vtt),
    DetectionCase(fixtureName: "fixture-vtt-tab.vtt", expectedType: .vtt),
    DetectionCase(fixtureName: "fixture-vtt-eof.vtt", expectedType: .vtt),
    DetectionCase(fixtureName: "fixture-realmedia-audio.rm", expectedType: .rm),
    DetectionCase(fixtureName: "fixture-realmedia-video.rm", expectedType: .rm),
    DetectionCase(fixtureName: "fixture-win2000.reg", expectedType: .reg),
    DetectionCase(fixtureName: "fixture-win95.reg", expectedType: .reg),
    DetectionCase(fixtureName: "fixture-unicode-tests.dat", expectedType: .dat),
    DetectionCase(fixtureName: "fixture-sample.pst", expectedType: .pst),
    DetectionCase(fixtureName: "fixture-cube_pc.drc", expectedType: .drc),
    DetectionCase(fixtureName: "fixture-line-weights.dwg", expectedType: .dwg),
    DetectionCase(fixtureName: "fixture-arm64.macho", expectedType: .macho),
    DetectionCase(fixtureName: "fixture-x86_64.macho", expectedType: .macho),
    DetectionCase(fixtureName: "fixture-i386.macho", expectedType: .macho),
    DetectionCase(fixtureName: "fixture-ppc7400.macho", expectedType: .macho),
    DetectionCase(fixtureName: "fixture-fat-binary.macho", expectedType: .macho),
    DetectionCase(fixtureName: "fixture2.asar", expectedType: .asar),
    DetectionCase(fixtureName: "fixture2.zip", expectedType: .zip),
]

private let baselineDetectionCases: [DetectionCase] = FileTypeExtension.allCases.compactMap {
    fileTypeExtension in
    guard let fileType = FileType.all(for: fileTypeExtension).first else {
        return nil
    }

    let fixtureName = "fixture.\(fileType.ext)"
    guard fixtureExists(named: fixtureName) else {
        return nil
    }

    return DetectionCase(fixtureName: fixtureName, expectedType: fileTypeExtension)
}

private func fixtureURL(named fixtureName: String) -> URL {
    fixturesDirectory.appending(path: fixtureName, directoryHint: .notDirectory)
}

private func fixtureExists(named fixtureName: String) -> Bool {
    FileManager.default.fileExists(atPath: fixtureURL(named: fixtureName).path())
}

private func fixtureData(named fixtureName: String) throws -> Data {
    try Data(contentsOf: fixtureURL(named: fixtureName), options: .mappedIfSafe)
}

@Suite("FileType")
struct FileTypeTests {
    @Test("detects baseline fixtures", arguments: baselineDetectionCases)
    func detectsBaselineFixture(_ detectionCase: DetectionCase) throws {
        let data = try fixtureData(named: detectionCase.fixtureName)
        #expect(FileType.detect(in: data)?.type == detectionCase.expectedType)
    }

    @Test("detects special-case fixtures", arguments: specialDetectionCases)
    func detectsSpecialFixture(_ detectionCase: DetectionCase) throws {
        let data = try fixtureData(named: detectionCase.fixtureName)
        #expect(FileType.detect(in: data)?.type == detectionCase.expectedType)
    }

    @Test("covers every public file type")
    func coversEveryPublicFileType() {
        let coveredTypes = Set((baselineDetectionCases + specialDetectionCases).map(\.expectedType))
        #expect(coveredTypes == Set(FileTypeExtension.allCases))
    }

    @Test("keeps detector metadata in sync")
    func keepsDetectorMetadataInSync() {
        #expect(Set(FileTypeMatch.all.map(\.type)) == Set(FileType.all.keys))
    }

    @Test("returns deterministic metadata ordering")
    func returnsDeterministicMetadataOrdering() {
        let allHEICTypes = FileType.all(for: .heic)
        #expect(
            allHEICTypes.map(\.mime) == [
                "image/heic",
                "image/heic-sequence",
                "image/heif",
                "image/heif-sequence",
            ])
    }

    @Test("exposes canonical extensions for public enum cases")
    func exposesCanonicalExtensions() {
        #expect(FileTypeExtension.threegp.canonicalFileExtension == "3gp")
        #expect(FileTypeExtension.sevenz.canonicalFileExtension == "7z")
        #expect(FileTypeExtension.ble.canonicalFileExtension == "blend")
        #expect(FileTypeExtension.heic.canonicalFileExtension == "heic")
    }

    @Test("derives mime groups from the major mime type")
    func derivesMIMEGroups() {
        #expect(FileType.all(for: .jpg).first?.mimeGroup == .image)
        #expect(FileType.all(for: .mp3).first?.mimeGroup == .audio)
        #expect(FileType.all(for: .woff).first?.mimeGroup == .font)
        #expect(FileType.all(for: .glb).first?.mimeGroup == .model)
        #expect(FileType.all(for: .ics).first?.mimeGroup == .text)
        #expect(FileType.all(for: .mp4).first?.mimeGroup == .video)
    }

    @Test("returns grouped metadata and requirements")
    func returnsGroupedMetadataAndRequirements() {
        let imageTypes = FileType.all(for: .image)
        #expect(!imageTypes.isEmpty)
        #expect(imageTypes.allSatisfy { $0.mimeGroup == .image })
        #expect(FileType.all(for: .audio).allSatisfy { $0.mimeGroup == .audio })
        #expect(FileType.dataRequirement(for: .application) == .fullFile)
        #expect(FileType.minimumPrefixBytes(for: .image) > 0)
    }

    @Test("reports prefix requirements for simple signatures")
    func reportsPrefixRequirementsForSimpleSignatures() {
        #expect(FileType.minimumPrefixBytes(for: .ac3) == 2)
        #expect(FileType.minimumPrefixBytes(for: .zip) == 4)
        #expect(FileType.minimumPrefixBytes(for: [.ac3, .zip, .cab]) == 4)
        #expect(FileType.dataRequirement(for: .zip) == .prefix(4))
        #expect(FileType.dataRequirement(for: [.ac3, .zip, .cab]) == .prefix(4))
    }

    @Test("reports full-file requirements for container scans")
    func reportsFullFileRequirementsForContainerScans() {
        #expect(FileType.minimumPrefixBytes(for: .docx) == 4)
        #expect(FileType.dataRequirement(for: .docx) == .fullFile)
        #expect(FileType.dataRequirement(for: .asar) == .fullFile)
        #expect(FileType.dataRequirement(for: [.ac3, .docx]) == .fullFile)
    }

    @Test("reads 64-bit integers correctly")
    func reads64BitIntegersCorrectly() {
        let bigEndianBytes = Data([0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08])
        let littleEndianBytes = Data([0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01])

        #expect(bigEndianBytes.getUInt64BE() == 0x0102_0304_0506_0708)
        #expect(littleEndianBytes.getUInt64LE() == 0x0102_0304_0506_0708)
    }

    @Test("detects Windows registry export variants")
    func detectsWindowsRegistryExportVariants() {
        let regedit4CRLF = Data("REGEDIT4\r\n\r\n[HKEY_CURRENT_USER\\Software\\Test]\r\n".utf8)
        let regedit4LF = Data("REGEDIT4\n\n[HKEY_CURRENT_USER\\Software\\Test]\n".utf8)
        let regedit5 =
            Data([0xFF, 0xFE])
            + ("Windows Registry Editor Version 5.00\r\n\r\n[HKEY_CURRENT_USER\\Software\\Test]\r\n"
                .data(using: .utf16LittleEndian) ?? Data())

        #expect(FileType.detect(in: regedit4CRLF)?.type == .reg)
        #expect(FileType.detect(in: regedit4LF)?.type == .reg)
        #expect(FileType.detect(in: regedit5)?.type == .reg)
    }

    @Test("detects from file urls without caller-managed data loading")
    func detectsFromFileURLs() throws {
        #expect(try FileType.detect(contentsOf: fixtureURL(named: "fixture.jpg"))?.type == .jpg)
        #expect(try FileType.detect(contentsOf: fixtureURL(named: "fixture.docx"))?.type == .docx)
    }

    @Test("detects within mime groups")
    func detectsWithinMIMEGroups() throws {
        let imageData = try fixtureData(named: "fixture.jpg")
        let audioData = try fixtureData(named: "fixture.mp3")
        let documentData = try fixtureData(named: "fixture.docx")

        #expect(FileType.detect(in: imageData, matching: .image)?.type == .jpg)
        #expect(FileType.detect(in: imageData, matching: .audio) == nil)
        #expect(FileType.detect(in: audioData, matching: .audio)?.type == .mp3)
        #expect(FileType.detect(in: documentData, matching: .application)?.type == .docx)
    }

    @Test("detects from file urls within mime groups")
    func detectsFromFileURLsWithinMIMEGroups() throws {
        #expect(
            try FileType.detect(contentsOf: fixtureURL(named: "fixture.jpg"), matching: .image)?
                .type
                == .jpg
        )
        #expect(
            try FileType.detect(contentsOf: fixtureURL(named: "fixture.docx"), matching: .image)
                == nil
        )
    }

    @Test("detects from file handles")
    func detectsFromFileHandles() throws {
        let fileHandle = try FileHandle(forReadingFrom: fixtureURL(named: "fixture.epub"))
        defer {
            fileHandle.closeFile()
        }

        #expect(try FileType.detect(using: fileHandle)?.type == .epub)
    }

    @Test("detects from file handles within mime groups")
    func detectsFromFileHandlesWithinMIMEGroups() throws {
        let fileHandle = try FileHandle(forReadingFrom: fixtureURL(named: "fixture.mp4"))
        defer {
            fileHandle.closeFile()
        }

        #expect(try FileType.detect(using: fileHandle, matching: .video)?.type == .mp4)
    }

    @Test("returns nil for truncated matroska header")
    func returnsNilForTruncatedMatroskaHeader() {
        let data = Data([0x1A, 0x45, 0xDF, 0xA3])
        #expect(FileType.detect(in: data) == nil)
    }

    @Test("returns nil for truncated asar header")
    func returnsNilForTruncatedAsarHeader() {
        let data = Data([0x04, 0x00, 0x00, 0x00])
        #expect(FileType.detect(in: data) == nil)
    }

    @Test("returns nil for truncated png header")
    func returnsNilForTruncatedPNGHeader() {
        let data = Data([0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A])
        #expect(FileType.detect(in: data) == nil)
    }

    @Test("returns nil for unknown data")
    func returnsNilForUnknownData() {
        let data = Data([0xDE, 0xAD, 0xBE, 0xEF, 0x00, 0x01, 0x02, 0x03])
        #expect(FileType.detect(in: data) == nil)
    }

    @Test("returns nil for malformed named fixtures")
    func returnsNilForMalformedNamedFixtures() throws {
        #expect(try FileType.detect(contentsOf: fixtureURL(named: "fixture-corrupt.png")) == nil)
        #expect(try FileType.detect(contentsOf: fixtureURL(named: "fixture-json.webp")) == nil)
        #expect(try FileType.detect(contentsOf: fixtureURL(named: "fixture.unicorn")) == nil)
        #expect(try FileType.detect(contentsOf: fixtureURL(named: "fixture-bad-offset.mp3")) == nil)
        #expect(
            try FileType.detect(contentsOf: fixtureURL(named: "fixture-bad-offset-10.mp3")) == nil)
    }
}
