import Foundation

public enum FileTypeExtension {
  case aac
  case ac3
  case ai
  case aif
  case ali
  case amr
  case ape
  case apng
  case ar
  case arr
  case arw
  case asf
  case avi
  case ble
  case bmp
  case bpg
  case bz2
  case cab
  case cr2
  case cr3
  case crx
  case cur
  case dcm
  case deb
  case dmg
  case dng
  case docx
  case dsf
  case eot
  case epub
  case exe
  case f4a
  case f4b
  case f4p
  case f4v
  case fla
  case flif
  case flv
  case gif
  case glb
  case gz
  case heic
  case ico
  case ics
  case it
  case jp2
  case jpg
  case jpm
  case jpx
  case jxr
  case ktx
  case lnk
  case lz
  case m4a
  case m4b
  case m4p
  case m4v
  case mid
  case mie
  case mj2
  case mobi
  case mov
  case mp1
  case mp2
  case mp3
  case mp4
  case mpc
  case mpg
  case msi
  case mts
  case mxf
  case nef
  case nes
  case odp
  case ods
  case odt
  case oga
  case ogg
  case ogm
  case ogv
  case ogx
  case opus
  case orf
  case otf
  case pdf
  case png
  case pptx
  case ps
  case psd
  case qcp
  case raf
  case rar
  case rpm
  case rtf
  case rw2
  case s3m
  case sevenz
  case shp
  case spx
  case sql
  case swf
  case tar
  case threeg2
  case threegp
  case tif
  case ttf
  case voc
  case wasm
  case wav
  case wma
  case wmv
  case woff
  case woff2
  case wv
  case xlsx
  case xm
  case xml
  case xpi
  case xz
  case Z
  case zip
}

public struct FileType {
  let type: FileTypeExtension
  let ext: String
  let mime: String

  private var bytesCount: Int? = nil
  private var matchString: [String]? = nil
  private var matchBytes: [[UInt8]]? = nil
  private var match: ((Data) -> Bool)? = nil
  
  static let all: [FileType] = [
    FileType(
      type: .bmp,
      ext: "bmp",
      mime: "image/bmp",
      matchBytes: [[0x42, 0x4D]]
    ),

    FileType(
      type: .ac3,
      ext: "ac3",
      mime: "audio/vnd.dolby.dd-raw",
      matchBytes: [[0x0B, 0x77]]
    ),

    FileType(
      type: .dmg,
      ext: "dmg",
      mime: "application/x-apple-diskimage",
      matchBytes: [[0x78, 0x01]]
    ),

    FileType(
      type: .exe,
      ext: "exe",
      mime: "application/x-msdownload",
      matchBytes: [[0x4D, 0x5A]]
    ),

    FileType(
      type: .ps,
      ext: "ps",
      mime: "application/postscript",
      matchBytes: [[0x25, 0x21]]
    ),

    FileType(
      type: .Z,
      ext: "Z",
      mime: "application/x-compress",
      matchBytes: [[0x1F, 0xA0], [0x1F, 0x9D]]
    ),

    FileType(
      type: .jpg,
      ext: "jpg",
      mime: "image/jpeg",
      matchBytes: [[0xFF, 0xD8, 0xFF]]
    ),

    FileType(
      type: .jxr,
      ext: "jxr",
      mime: "image/vnd.ms-photo",
      matchBytes: [[0x49, 0x49, 0xBC]]
    ),

    FileType(
      type: .gz,
      ext: "gz",
      mime: "application/gzip",
      matchBytes: [[0x1F, 0x8B, 0x8]]
    ),

    FileType(
      type: .bz2,
      ext: "bz2",
      mime: "application/x-bzip2",
      matchBytes: [[0x42, 0x5A, 0x68]]
    ),

    FileType(
      type: .mpc,
      ext: "mpc",
      mime: "audio/x-musepack",
      matchString: ["MP+"]
    ),

    FileType(
      type: .gif,
      ext: "gif",
      mime: "image/gif",
      matchBytes: [[0x47, 0x49, 0x46]]
    ),

    FileType(
      type: .flif,
      ext: "flif",
      mime: "image/flif",
      matchString: ["FLIF"]
    ),

    FileType(
      type: .psd,
      ext: "psd",
      mime: "image/vnd.adobe.photoshop",
      matchString: ["8BPS"]
    ),

    FileType(
      type: .mpc,
      ext: "mpc",
      mime: "audio/x-musepack",
      matchString: ["MPCK"]
    ),

    FileType(
      type: .aif,
      ext: "aif",
      mime: "audio/aiff",
      matchString: ["FORM"]
    ),

    FileType(
      type: .swf,
      ext: "swf",
      mime: "application/x-shockwave-flash",
      matchBytes: [[0x43, 0x57, 0x53], [0x46, 0x57, 0x53]]
    ),

    // Zip-based file formats
    FileType(
      type: .xpi,
      ext: "xpi",
      mime: "application/x-xpinstall",
      matchBytes: [[0x50, 0x4B, 0x3, 0x4]],
      match: { matchZipHeader($0) { $0.filename == "META-INF/mozilla.rsa" }}
    ),

    FileType(
      type: .docx,
      ext: "docx",
      mime: "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
      matchBytes: [[0x50, 0x4B, 0x3, 0x4]],
      match: { matchZipHeader($0) {
        matchMSOffice($0, type: "word")
      }}
    ),

    FileType(
      type: .pptx,
      ext: "pptx",
      mime: "application/vnd.openxmlformats-officedocument.presentationml.presentation",
      matchBytes: [[0x50, 0x4B, 0x3, 0x4]],
      match: { matchZipHeader($0) { matchMSOffice($0, type: "ppt") }}
    ),

    FileType(
      type: .xlsx,
      ext: "xlsx",
      mime: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      matchBytes: [[0x50, 0x4B, 0x3, 0x4]],
      match: { matchZipHeader($0) { matchMSOffice($0, type: "xl", startsWith: "xl/") }}
    ),

    FileType(
      type: .epub,
      ext: "epub",
      mime: "application/epub+zip",
      matchBytes: [[0x50, 0x4B, 0x3, 0x4]],
      match: { matchZipHeader($0) { $0.mimeType == "application/epub+zip" }}
    ),

    FileType(
      type: .odt,
      ext: "odt",
      mime: "application/vnd.oasis.opendocument.text",
      matchBytes: [[0x50, 0x4B, 0x3, 0x4]],
      match: { matchZipHeader($0) { $0.mimeType == "application/vnd.oasis.opendocument.text" }}
    ),

    FileType(
      type: .ods,
      ext: "ods",
      mime: "application/vnd.oasis.opendocument.spreadsheet",
      matchBytes: [[0x50, 0x4B, 0x3, 0x4]],
      match: { matchZipHeader($0) { $0.mimeType == "application/vnd.oasis.opendocument.spreadsheet" }}
    ),

    FileType(
      type: .odp,
      ext: "odp",
      mime: "application/vnd.oasis.opendocument.presentation",
      matchBytes: [[0x50, 0x4B, 0x3, 0x4]],
      match: { matchZipHeader($0) { $0.mimeType == "application/vnd.oasis.opendocument.presentation" }}
    ),

    FileType(
      type: .zip,
      ext: "zip",
      mime: "application/zip",
      matchBytes: [
        [0x50, 0x4B, 0x3, 0x4],
        [0x50, 0x4B, 0x3, 0x6],
        [0x50, 0x4B, 0x3, 0x8],

        [0x50, 0x4B, 0x5, 0x4],
        [0x50, 0x4B, 0x5, 0x6],
        [0x50, 0x4B, 0x5, 0x8],

        [0x50, 0x4B, 0x7, 0x4],
        [0x50, 0x4B, 0x7, 0x6],
        [0x50, 0x4B, 0x7, 0x8],
      ]
    ),

    // ogg container
    // Needs to be before `ogg` check
    FileType(
      type: .opus,
      ext: "opus",
      mime: "audio/opus",
      bytesCount: 36,
      matchString: ["OggS"],
      match: { matchPatterns($0, match: [
        [
          .byte(0x4F), .byte(0x70), .byte(0x75), .byte(0x73),
          .byte(0x48), .byte(0x65), .byte(0x61), .byte(0x64)
        ]
      ], offset: 28) }
    ),

    FileType(
      type: .ogv,
      ext: "ogv",
      mime: "video/ogg",
      bytesCount: 35,
      matchString: ["OggS"],
      match: { matchPatterns($0, match: [
        [
          .byte(0x80), .byte(0x74), .byte(0x68), .byte(0x65),
          .byte(0x6F), .byte(0x72), .byte(0x61)
        ]
      ], offset: 28) }
    ),

    FileType(
      type: .ogm,
      ext: "ogm",
      mime: "video/ogg",
      bytesCount: 35,
      matchString: ["OggS"],
      match: { matchPatterns($0, match: [
        [
          .byte(0x01), .byte(0x76), .byte(0x69), .byte(0x64),
          .byte(0x65), .byte(0x6F), .byte(0x00)
        ]
      ], offset: 28) }
    ),

    FileType(
      type: .oga,
      ext: "oga",
      mime: "audio/ogg",
      bytesCount: 33,
      matchString: ["OggS"],
      match: { matchPatterns($0, match: [
        [
          .byte(0x7F), .byte(0x46), .byte(0x4C), .byte(0x41),
          .byte(0x43)
        ]
      ], offset: 28) }
    ),

    FileType(
      type: .spx,
      ext: "spx",
      mime: "audio/ogg",
      bytesCount: 35,
      matchString: ["OggS"],
      match: { matchPatterns($0, match: [
        [
          .byte(0x53), .byte(0x70), .byte(0x65), .byte(0x65),
          .byte(0x78), .byte(0x20), .byte(0x20)
        ]
      ], offset: 28) }
    ),

    FileType(
      type: .ogg,
      ext: "ogg",
      mime: "audio/ogg",
      bytesCount: 35,
      matchString: ["OggS"],
      match: { matchPatterns($0, match: [
        [
          .byte(0x01), .byte(0x76), .byte(0x6F), .byte(0x72),
          .byte(0x62), .byte(0x69), .byte(0x73)
        ]
      ], offset: 28) }
    ),

    FileType(
      type: .ogx,
      ext: "ogx",
      mime: "application/ogg",
      matchString: ["OggS"]
    ),

    //File Type Box Formats
    FileType(
      type: .heic,
      ext: "heic",
      mime: "image/heif",
      bytesCount: 12,
      match: { matchPatterns($0, match: [
        [
          .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
          .byte(0x6D), .byte(0x69), .byte(0x66), .byte(0x31)  // mif1
        ]
      ], offset: 4) }
    ),

    FileType(
      type: .heic,
      ext: "heic",
      mime: "image/heif-sequence",
      bytesCount: 12,
      match: { matchPatterns($0, match: [
        [
          .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
          .byte(0x6D), .byte(0x73), .byte(0x66), .byte(0x31)  // msf1
        ]
      ], offset: 4) }
    ),

    FileType(
      type: .heic,
      ext: "heic",
      mime: "image/heic",
      bytesCount: 12,
      match: { matchPatterns($0, match: [
        [
          .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
          .byte(0x68), .byte(0x65), .byte(0x69), .byte(0x63)  // heic
        ],

        [
          .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
          .byte(0x68), .byte(0x65), .byte(0x69), .byte(0x78)  // heix
        ]
      ], offset: 4) }
    ),

    FileType(
      type: .heic,
      ext: "heic",
      mime: "image/heic-sequence",
      bytesCount: 12,
      match: { matchPatterns($0, match: [
        [
          .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
          .byte(0x68), .byte(0x65), .byte(0x76), .byte(0x63)  // hevc
        ],

        [
          .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
          .byte(0x68), .byte(0x65), .byte(0x76), .byte(0x78)  // hevx
        ]
      ], offset: 4) }
    ),

    FileType(
      type: .mov,
      ext: "mov",
      mime: "video/quicktime",
      bytesCount: 10,
      match: { matchPatterns($0, match: [
        [
          .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
          .byte(0x71), .byte(0x74)                            // qt
        ]
      ], offset: 4) }
    ),

    FileType(
      type: .m4v,
      ext: "m4v",
      mime: "video/x-m4v",
      bytesCount: 12,
      match: { matchPatterns($0, match: [
        [
          .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
          .byte(0x4d), .byte(0x34), .byte(0x56)               // M4V
        ],

        [
          .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
          .byte(0x4d), .byte(0x34), .byte(0x56), .byte(0x48)  // M4VH
        ],

        [
          .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
          .byte(0x4d), .byte(0x34), .byte(0x56), .byte(0x50)  // M4VP
        ],

      ], offset: 4) }
    ),

    FileType(
      type: .m4p,
      ext: "m4p",
      mime: "video/mp4",
      bytesCount: 11,
      match: { matchPatterns($0, match: [[
        .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
        .byte(0x4d), .byte(0x34), .byte(0x50)               // M4P
      ]], offset: 4) }
    ),

    FileType(
      type: .m4b,
      ext: "m4b",
      mime: "audio/mp4",
      bytesCount: 11,
      match: { matchPatterns($0, match: [[
        .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
        .byte(0x4d), .byte(0x34), .byte(0x42)               // M4B
      ]], offset: 4) }
    ),

    FileType(
      type: .m4a,
      ext: "m4a",
      mime: "audio/x-m4a",
      bytesCount: 11,
      match: { matchPatterns($0, match: [[
        .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
        .byte(0x4d), .byte(0x34), .byte(0x41)               // M4A
      ]], offset: 4) }
    ),

    FileType(
      type: .f4v,
      ext: "f4v",
      mime: "video/mp4",
      bytesCount: 11,
      match: { matchPatterns($0, match: [[
        .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
        .byte(0x46), .byte(0x34), .byte(0x56)               // F4V
      ]], offset: 4) }
    ),

    FileType(
      type: .f4p,
      ext: "f4p",
      mime: "video/mp4",
      bytesCount: 11,
      match: { matchPatterns($0, match: [[
        .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
        .byte(0x46), .byte(0x34), .byte(0x50)               // F4P
      ]], offset: 4) }
    ),

    FileType(
      type: .f4a,
      ext: "f4a",
      mime: "audio/mp4",
      bytesCount: 11,
      match: { matchPatterns($0, match: [[
        .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
        .byte(0x46), .byte(0x34), .byte(0x41)               // F4A
      ]], offset: 4) }
    ),

    FileType(
      type: .f4b,
      ext: "f4b",
      mime: "audio/mp4",
      bytesCount: 11,
      match: { matchPatterns($0, match: [[
        .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
        .byte(0x46), .byte(0x34), .byte(0x42)               // F4B
      ]], offset: 4) }
    ),

    FileType(
      type: .cr3,
      ext: "cr3",
      mime: "image/x-canon-cr3",
      bytesCount: 11,
      match: { matchPatterns($0, match: [[
        .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
        .byte(0x63), .byte(0x72), .byte(0x78)               // crx
      ]], offset: 4) }
    ),

    FileType(
      type: .threeg2,
      ext: "3g2",
      mime: "video/3gpp2",
      bytesCount: 11,
      match: { matchPatterns($0, match: [[
        .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
        .byte(0x33), .byte(0x67), .byte(0x32)               // 3g2
      ]], offset: 4) }
    ),

    FileType(
      type: .threegp,
      ext: "3gp",
      mime: "video/3gpp",
      bytesCount: 10,
      match: { matchPatterns($0, match: [[
        .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
        .byte(0x33), .byte(0x67)                            // 3g
      ]], offset: 4) }
    ),

    FileType(
      type: .mp4,
      ext: "mp4",
      mime: "video/mp4",
      bytesCount: 8,
      match: { matchPatterns($0, match: [[
        .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
      ]], offset: 4) }
    ),


    FileType(
      type: .mid,
      ext: "mid",
      mime: "audio/midi",
      matchString: ["MThd"]
    ),

    FileType(
      type: .woff,
      ext: "woff",
      mime: "font/woff",
      bytesCount: 12,
      matchString: ["wOFF"],
      match: {
        matchPatterns($0, match: [
          [.byte(0x0), .byte(0x01), .byte(0x0), .byte(0x0)],
          [.byte(0x4F), .byte(0x54), .byte(0x54), .byte(0x4F)]
        ], offset: 4)
      }
    ),

    FileType(
      type: .woff2,
      ext: "woff2",
      mime: "font/woff2",
      bytesCount: 12,
      matchString: ["wOF2"],
      match: {
        matchPatterns($0, match: [
          [.byte(0x00), .byte(0x01), .byte(0x0), .byte(0x00)],
          [.byte(0x4F), .byte(0x54), .byte(0x54), .byte(0x4F)]
        ], offset: 4)
      }
    ),

    FileType(
      type: .dsf,
      ext: "dsf",
      mime: "audio/x-dsf", // Non-standard
      matchString: ["DSD "]
    ),

    FileType(
      type: .lz,
      ext: "lz",
      mime: "application/x-lzip",
      matchString: ["LZIP"]
    ),

    FileType(
      type: .fla,
      ext: "flac",
      mime: "audio/x-flac",
      matchString: ["fLaC"]
    ),

    FileType(
      type: .bpg,
      ext: "bpg",
      mime: "image/bpg",
      matchBytes: [[0x42, 0x50, 0x47, 0xFB]]
    ),

    FileType(
      type: .wv,
      ext: "wv",
      mime: "audio/wavpack",
      matchString: ["wvpk"]
    ),

    FileType(
      type: .ai,
      ext: "ai",
      mime: "application/postscript",
      matchString: ["%PDF"],
      match: { findString($0, "Adobe Illustrator", ignore: 1350) }
    ),

    FileType(
      type: .pdf,
      ext: "pdf",
      mime: "application/pdf",
      matchString: ["%PDF"]
    ),

    FileType(
      type: .wasm,
      ext: "wasm",
      mime: "application/wasm",
      matchBytes: [[0x00, 0x61, 0x73, 0x6D]]
    ),

    // tiff, little-endian type based file formats
    FileType(
      type: .cr2,
      ext: "cr2",
      mime: "image/x-canon-cr2",
      bytesCount: 10,
      matchBytes: [[0x49, 0x49, 0x2A, 0x0]],
      match: {
        matchPatterns($0, match: [[.byte(0x43), .byte(0x52)]], offset: 8)
      }
    ),

    FileType(
      type: .nef,
      ext: "nef",
      mime: "image/x-nikon-nef",
      bytesCount: 12,
      matchBytes: [[0x49, 0x49, 0x2A, 0x0]],
      match: {
        matchPatterns($0, match: [
          [.byte(0x1C), .byte(0x0), .byte(0xFE), .byte(0x0)],
          [.byte(0x1F), .byte(0x0), .byte(0x0B), .byte(0x0)]
        ], offset: 8)
      }
    ),

    FileType(
      type: .dng,
      ext: "dng",
      mime: "image/x-adobe-dng",
      bytesCount: 12,
      matchBytes: [[0x49, 0x49, 0x2A, 0x0]],
      match: {
        matchPatterns($0, match: [
          [
            .byte(0x08), .byte(0x0), .byte(0x0), .byte(0x0),
            .byte(0x2D), .byte(0x0), .byte(0xFE), .byte(0x0)
          ],
          [
            .byte(0x08), .byte(0x0), .byte(0x0), .byte(0x0),
            .byte(0x27), .byte(0x0), .byte(0xFE), .byte(0x0)
          ]
        ], offset: 4)
      }
    ),

    FileType(
      type: .arw,
      ext: "arw",
      mime: "image/x-sony-arw",
      bytesCount: 24,
      matchBytes: [[0x49, 0x49, 0x2A, 0x0]],
      match: {
        matchPatterns($0, match: [
          [
            .byte(0x10), .byte(0xFB), .byte(0x86), .byte(0x01),
            .any,
            .byte(0x0), .byte(0xFE), .byte(0x00), .byte(0x04),
            .byte(0x0), .byte(0x01), .byte(0x00), .byte(0x00),
            .byte(0x0), .byte(0x01), .byte(0x00), .byte(0x00),
            .byte(0x0), .byte(0x03), .byte(0x01)
          ],
          [
            .byte(0x08), .byte(0x00), .byte(0x00), .byte(0x00),
            .any,
            .byte(0x0), .byte(0xFE), .byte(0x00), .byte(0x04),
            .byte(0x0), .byte(0x01), .byte(0x00), .byte(0x00),
            .byte(0x0), .byte(0x01), .byte(0x00), .byte(0x00),
            .byte(0x0), .byte(0x03), .byte(0x01)
          ],
        ], offset: 4)
      }
    ),

    FileType(
      type: .tif,
      ext: "tif",
      mime: "image/tiff",
      matchBytes: [
        [0x49, 0x49, 0x2A, 0x0],
        [0x4D, 0x4D, 0x0, 0x2A]
      ]
    ),

    FileType(
      type: .ape,
      ext: "ape",
      mime: "audio/ape",
      matchString: ["MAC "]
    ),

    //matroska

    FileType(
      type: .avi,
      ext: "avi",
      mime: "video/vnd.avi",
      bytesCount: 11,
      matchBytes: [[0x52, 0x49, 0x46, 0x46]],
      match: {
        matchPatterns($0, match: [
          [.byte(0x41), .byte(0x56), .byte(0x49)]
        ], offset: 8)
      }
    ),

    FileType(
      type: .wav,
      ext: "wav",
      mime: "audio/vnd.wave",
      bytesCount: 12,
      matchBytes: [[0x52, 0x49, 0x46, 0x46]],
      match: {
        matchPatterns($0, match: [
          [.byte(0x57), .byte(0x41), .byte(0x56), .byte(0x45)]
        ], offset: 8)
      }
    ),

    FileType(
      type: .qcp,
      ext: "qcp",
      mime: "audio/qcelp",
      bytesCount: 12,
      matchBytes: [[0x52, 0x49, 0x46, 0x46]],
      match: {
        matchPatterns($0, match: [
          [.byte(0x51), .byte(0x4C), .byte(0x43), .byte(0x4D)]
        ], offset: 8)
      }
    ),

    FileType(
      type: .sql,
      ext: "sqlite",
      mime: "application/x-sqlite3",
      matchString: ["SQLi"]
    ),

    FileType(
      type: .nes,
      ext: "nes",
      mime: "application/x-nintendo-nes-rom",
      matchBytes: [[0x4E, 0x45, 0x53, 0x1A]]
    ),

    FileType(
      type: .crx,
      ext: "crx",
      mime: "application/x-google-chrome-extension",
      matchString: ["Cr24"]
    ),

    FileType(
      type: .cab,
      ext: "cab",
      mime: "application/vnd.ms-cab-compressed",
      matchString: ["MSCF", "ISc("]
    ),

    FileType(
      type: .rpm,
      ext: "rpm",
      mime: "application/x-rpm",
      matchBytes: [[0xED, 0xAB, 0xEE, 0xDB]]
    ),

    // -- 5-byte signatures --

    FileType(
      type: .otf,
      ext: "otf",
      mime: "font/otf",
      matchBytes: [[0x4F, 0x54, 0x54, 0x4F, 0x00]]
    ),

    FileType(
      type: .amr,
      ext: "amr",
      mime: "audio/amr",
      matchString: ["#!AMR"]
    ),

    FileType(
      type: .rtf,
      ext: "rtf",
      mime: "application/rtf",
      matchString: ["{\\rtf"]
    ),

    FileType(
      type: .flv,
      ext: "flv",
      mime: "video/x-flv",
      matchBytes: [[0x46, 0x4C, 0x56, 0x01]]
    ),

    FileType(
      type: .it,
      ext: "it",
      mime: "audio/x-it",
      matchString: ["IMPM"]
    ),

    //  MPEG-PS, MPEG-1 Part 1
    FileType(
      type: .mpg,
      ext: "mpg", // May also be .ps, .mpeg
      mime: "video/MP1S",
      bytesCount: 5,
      matchBytes: [[0x00, 0x00, 0x01, 0xBA]],
      match: {
        matchPatterns($0, match: [[.byte(0x21)]], offset: 4, mask: [0xF1])
      }
    ),

    // MPEG-PS, MPEG-2 Part 1
    FileType(
      type: .mpg,
      ext: "mpg", // May also be .mpg, .m2p, .vob or .sub
      mime: "video/MP2P",
      bytesCount: 5,
      matchBytes: [[0x00, 0x00, 0x01, 0xBA]],
      match: {
        matchPatterns($0, match: [[.byte(0x44)]], offset: 4, mask: [0xC4])
      }
    ),

    FileType(
      type: .xz,
      ext: "xz",
      mime: "application/x-xz",
      matchBytes: [[0xFD, 0x37, 0x7A, 0x58, 0x5A, 0x00]]
    ),

    FileType(
      type: .xml,
      ext: "xml",
      mime: "application/xml",
      matchString: ["<?xml "]
    ),

    FileType(
      type: .ics,
      ext: "ics",
      mime: "text/calendar",
      matchString: ["BEGIN:"]
    ),

    FileType(
      type: .sevenz,
      ext: "7z",
      mime: "application/x-7z-compressed",
      matchBytes: [[0x37, 0x7A, 0xBC, 0xAF, 0x27, 0x1C]]
    ),

    FileType(
      type: .rar,
      ext: "rar",
      mime: "application/x-rar-compressed",
      matchBytes: [
        [0x52, 0x61, 0x72, 0x21, 0x1A, 0x7, 0x0],
        [0x52, 0x61, 0x72, 0x21, 0x1A, 0x7, 0x1]
      ]
    ),

    // -- 7-byte signatures --

    FileType(
      type: .ble,
      ext: "blend",
      mime: "application/x-blender",
      matchString: ["BLENDER"]
    ),

    FileType(
      type: .deb,
      ext: "deb",
      mime: "application/x-deb",
      bytesCount: 21,
      matchString: ["!<arch>"],
      match: { matchPatterns($0, match: [
        [
          .byte(0x64), .byte(0x65), .byte(0x62), .byte(0x69),
          .byte(0x61), .byte(0x6e), .byte(0x2d), .byte(0x62),
          .byte(0x69), .byte(0x6e), .byte(0x61), .byte(0x72),
          .byte(0x79)
        ]
      ], offset: 8)}
    ),

    FileType(
      type: .ar,
      ext: "ar",
      mime: "application/x-unix-archive",
      matchString: ["!<arch>"]
    ),

    FileType(
      type: .apng,
      ext: "apng",
      mime: "image/apng",
      bytesCount: 32,
      matchBytes: [[0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]],
      match: findAPNG
    ),

    FileType(
      type: .png,
      ext: "png",
      mime: "image/png",
      matchBytes: [[0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]]
    ),

    FileType(
      type: .arr,
      ext: "arrow",
      mime: "application/x-apache-arrow",
      matchBytes: [[0x41, 0x52, 0x52, 0x4F, 0x57, 0x31, 0x00, 0x00]]
    ),

    FileType(
      type: .glb,
      ext: "glb",
      mime: "model/gltf-binary",
      matchBytes: [[0x67, 0x6C, 0x54, 0x46, 0x02, 0x00, 0x00, 0x00]]
    ),

    FileType(
      type: .mov,
      ext: "mov",
      mime: "video/quicktime",
      bytesCount: 8,
      match: {
        matchPatterns($0, match: [
          [.byte(0x66), .byte(0x72), .byte(0x65), .byte(0x65)], // `free`
          [.byte(0x6D), .byte(0x64), .byte(0x61), .byte(0x74)], // `mdat` MJPEG
          [.byte(0x6D), .byte(0x6F), .byte(0x6F), .byte(0x76)], // `moov`
          [.byte(0x77), .byte(0x69), .byte(0x64), .byte(0x65)]  // `wide`
        ], offset: 4)
      }
    ),

    FileType(
      type: .orf,
      ext: "orf",
      mime: "image/x-olympus-orf",
      matchBytes: [[0x49, 0x49, 0x52, 0x4F, 0x08, 0x00, 0x00, 0x00, 0x18]]
    ),

    // -- 12-byte signatures --

    FileType(
      type: .rw2,
      ext: "rw2",
      mime: "image/x-panasonic-rw2",
      matchBytes: [[0x49, 0x49, 0x55, 0x00, 0x18, 0x00, 0x00, 0x00, 0x88, 0xE7, 0x74, 0xD8]]
    ),

    FileType(
      type: .wma,
      ext: "wma",
      mime: "audio/x-ms-wma",
      bytesCount: 1024,
      matchBytes: [[
        0x30, 0x26, 0xB2, 0x75,
        0x8E, 0x66, 0xCF, 0x11,
        0xA6, 0xD9
      ]],
      match: { matchAsfHeader($0, [
        0x40, 0x9E, 0x69, 0xF8,
        0x4D, 0x5B, 0xCF, 0x11,
        0xA8, 0xFD, 0x00, 0x80,
        0x5F, 0x5C, 0x44, 0x2B
      ]) }
    ),

    FileType(
      type: .wmv,
      ext: "wmv",
      mime: "video/x-ms-asf",
      bytesCount: 1024,
      matchBytes: [[
        0x30, 0x26, 0xB2, 0x75,
        0x8E, 0x66, 0xCF, 0x11,
        0xA6, 0xD9
      ]],
      match: { matchAsfHeader($0, [
        0xC0, 0xEF, 0x19, 0xBC,
        0x4D, 0x5B, 0xCF, 0x11,
        0xA8, 0xFD, 0x00, 0x80,
        0x5F, 0x5C, 0x44, 0x2B
      ]) }
    ),

    FileType(
      type: .asf,
      ext: "asf",
      mime: "application/vnd.ms-asf",
      matchBytes: [[
        0x30, 0x26, 0xB2, 0x75,
        0x8E, 0x66, 0xCF, 0x11,
        0xA6, 0xD9
      ]]
    ),

    FileType(
      type: .ktx,
      ext: "ktx",
      mime: "image/ktx",
      matchBytes: [[0xAB, 0x4B, 0x54, 0x58, 0x20, 0x31, 0x31, 0xBB, 0x0D, 0x0A, 0x1A, 0x0A]]
    ),

    FileType(
      type: .mie,
      ext: "mie",
      mime: "application/x-mie",
      bytesCount: 8,
      match: {
        matchPatterns($0, match: [
          [.byte(0x7E), .byte(0x10), .byte(0x04), .any,
           .byte(0x30), .byte(0x4D), .byte(0x49), .byte(0x45)],
          [.byte(0x7E), .byte(0x18), .byte(0x04), .any,
           .byte(0x30), .byte(0x4D), .byte(0x49), .byte(0x45)]
        ])
      }
    ),

    FileType(
      type: .shp,
      ext: "shp",
      mime: "application/x-esri-shape",
      bytesCount: 14,
      match: {
        matchPatterns($0, match: [
          [
            .byte(0x27), .byte(0x0A), .byte(0x00), .byte(0x00),
            .byte(0x00), .byte(0x00), .byte(0x00), .byte(0x00),
            .byte(0x00), .byte(0x00), .byte(0x00), .byte(0x00)
          ],
        ], offset: 2)
    }
    ),

    // JPEG-2000 family
    FileType(
      type: .jp2,
      ext: "jp2",
      mime: "image/jp2",
      bytesCount: 24,
      match: {
        matchPatterns($0, match: [
          [
            .byte(0x00), .byte(0x00), .byte(0x00), .byte(0x0C),
            .byte(0x6A), .byte(0x50), .byte(0x20), .byte(0x20),
            .byte(0x0D), .byte(0x0A), .byte(0x87), .byte(0x0A),
            .any,        .any,        .any,        .any,
            .any,        .any,        .any,        .any,
            .byte(0x6A), .byte(0x70), .byte(0x32), .byte(0x20)
          ],
        ])
      }
    ),

    FileType(
      type: .jpx,
      ext: "jpx",
      mime: "image/jpx",
      bytesCount: 24,
      match: {
        matchPatterns($0, match: [
          [
            .byte(0x00), .byte(0x00), .byte(0x00), .byte(0x0C),
            .byte(0x6A), .byte(0x50), .byte(0x20), .byte(0x20),
            .byte(0x0D), .byte(0x0A), .byte(0x87), .byte(0x0A),
            .any,        .any,        .any,        .any,
            .any,        .any,        .any,        .any,
            .byte(0x6A), .byte(0x70), .byte(0x78), .byte(0x20)
          ],
        ])
      }
    ),

    FileType(
      type: .jpm,
      ext: "jpm",
      mime: "image/jpm",
      bytesCount: 24,
      match: {
        matchPatterns($0, match: [
          [
            .byte(0x00), .byte(0x00), .byte(0x00), .byte(0x0C),
            .byte(0x6A), .byte(0x50), .byte(0x20), .byte(0x20),
            .byte(0x0D), .byte(0x0A), .byte(0x87), .byte(0x0A),
            .any,        .any,        .any,        .any,
            .any,        .any,        .any,        .any,
            .byte(0x6A), .byte(0x70), .byte(0x6D), .byte(0x20)
          ],
        ])
      }
    ),

    FileType(
      type: .mj2,
      ext: "mj2",
      mime: "image/mj2",
      bytesCount: 24,
      match: {
        matchPatterns($0, match: [
          [
            .byte(0x00), .byte(0x00), .byte(0x00), .byte(0x0C),
            .byte(0x6A), .byte(0x50), .byte(0x20), .byte(0x20),
            .byte(0x0D), .byte(0x0A), .byte(0x87), .byte(0x0A),
            .any,        .any,        .any,        .any,
            .any,        .any,        .any,        .any,
            .byte(0x6D), .byte(0x6A), .byte(0x70), .byte(0x32)
          ],
        ])
      }
    ),

    // -- Unsafe signatures --
    FileType(
      type: .mpg,
      ext: "mpg",
      mime: "video/mpeg",
      matchBytes: [[0x0, 0x0, 0x1, 0xBA], [0x0, 0x0, 0x1, 0xB3]]
    ),

    FileType(
      type: .ttf,
      ext: "ttf",
      mime: "font/ttf",
      matchBytes: [[0x00, 0x01, 0x00, 0x00, 0x00]]
    ),

    FileType(
      type: .ico,
      ext: "ico",
      mime: "image/x-icon",
      matchBytes: [[0x00, 0x00, 0x01, 0x00]]
    ),

    FileType(
      type: .cur,
      ext: "cur",
      mime: "image/x-icon",
      matchBytes: [[0x00, 0x00, 0x02, 0x00]]
    ),

    // Increase sample size from 12 to 256.

    // `raf` is here just to keep all the raw image detectors together.
    FileType(
      type: .raf,
      ext: "raf",
      mime: "image/x-fujifilm-raf",
      matchString: ["FUJIFILMCCD-RAW"]
    ),

    FileType(
      type: .xm,
      ext: "xm",
      mime: "audio/x-xm",
      matchString: ["Extended Module:"]
    ),

    FileType(
      type: .voc,
      ext: "voc",
      mime: "audio/x-voc",
      matchString: ["Creative Voice File"]
    ),

    FileType(
      type: .msi,
      ext: "msi",
      mime: "application/x-msi",
      matchBytes: [[0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3E]]
    ),

    FileType(
      type: .mxf,
      ext: "mxf",
      mime: "application/mxf",
      matchBytes: [[0x06, 0x0E, 0x2B, 0x34, 0x02, 0x05, 0x01, 0x01, 0x0D, 0x01, 0x02, 0x01, 0x01, 0x02]]
    ),

    FileType(
      type: .s3m,
      ext: "s3m",
      mime: "audio/x-s3m",
      bytesCount: 44 + 4,
      match: { matchPatterns($0, match: [
        [.byte(0x53), .byte(0x43), .byte(0x52), .byte(0x4D)]
      ], offset: 44)}
    ),

    FileType(
      type: .mts,
      ext: "mts",
      mime: "video/mp2t",
      bytesCount: 197,
      match: {
        matchPatterns($0, match: [[.byte(0x47)]], offset: 4) &&
        (
          matchPatterns($0, match: [[.byte(0x47)]], offset: 192) ||
          matchPatterns($0, match: [[.byte(0x47)]], offset: 196)
        )
      }
    ),

    FileType(
      type: .mobi,
      ext: "mobi",
      mime: "application/x-mobipocket-ebook",
      bytesCount: 60 + 8,
      match: { matchPatterns($0, match: [
        [
          .byte(0x42), .byte(0x4F), .byte(0x4F), .byte(0x4B),
          .byte(0x4D), .byte(0x4F), .byte(0x42), .byte(0x49)
        ]
      ], offset: 60)}
    ),

    FileType(
      type: .dcm,
      ext: "dcm",
      mime: "application/dicom",
      bytesCount: 128 + 4,
      match: { matchPatterns($0, match: [
        [.byte(0x44), .byte(0x49), .byte(0x43), .byte(0x4D)]
      ], offset: 128)}
    ),

    FileType(
      type: .lnk,
      ext: "lnk",
      mime: "application/x.ms.shortcut", // Invented by us
      matchBytes: [[0x4C, 0x00, 0x00, 0x00, 0x01, 0x14, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]]
    ),

    FileType(
      type: .ali,
      ext: "alias",
      mime: "application/x.apple.alias", // Invented by us
      matchBytes: [[0x62, 0x6F, 0x6F, 0x6B, 0x00, 0x00, 0x00, 0x00, 0x6D, 0x61, 0x72, 0x6B, 0x00, 0x00, 0x00, 0x00]]
    ),

    FileType(
      type: .eot,
      ext: "eot",
      mime: "application/vnd.ms-fontobject",
      bytesCount: 36,
      match: {
        matchPatterns($0, match: [[.byte(0x4C), .byte(0x50)]], offset: 34) &&
        (
          matchPatterns($0, match: [[.byte(0x00), .byte(0x00), .byte(0x01)]], offset: 8) ||
          matchPatterns($0, match: [[.byte(0x01), .byte(0x00), .byte(0x02)]], offset: 8) ||
          matchPatterns($0, match: [[.byte(0x02), .byte(0x00), .byte(0x02)]], offset: 8)
        )
      }
    ),

    // Sample size 512

    FileType(
      type: .tar,
      ext: "tar",
      mime: "application/x-tar",
      bytesCount: 512,
      match: { matchPatterns(
        $0,
        match: [[
          .byte(0x30), .byte(0x30), .byte(0x30), .byte(0x30),
          .byte(0x30), .byte(0x30)
          ]],
        offset: 148,
        mask: [0xF8, 0xF8, 0xF8, 0xF8, 0xF8, 0xF8]
      ) && tarHeaderChecksumMatches($0)
      }
    ),

    FileType(
      type: .aac,
      ext: "aac",
      mime: "audio/aac",
      bytesCount: 18,
      match: { matchMPEGHeader($0, match: 0x10, mask: 0x16) }
    ),

    FileType(
      type: .mp3,
      ext: "mp3",
      mime: "audio/mpeg",
      bytesCount: 18,
      match: { matchMPEGHeader($0, match: 0x02, mask: 0x06) }
    ),

    FileType(
      type: .mp2,
      ext: "mp2",
      mime: "audio/mpeg",
      bytesCount: 18,
      match: { matchMPEGHeader($0, match: 0x04, mask: 0x06) }
    ),

    FileType(
      type: .mp1,
      ext: "mp1",
      mime: "audio/mpeg",
      bytesCount: 18,
      match: { matchMPEGHeader($0, match: 0x06, mask: 0x06) }
    ),

    FileType(
      type: .mp3,
      ext: "mp3",
      mime: "audio/mpeg",
      matchString: ["ID3"]
    ),

  ]
}

public extension FileType {
  static func getBytesCountFor(type: FileTypeExtension) -> Int {
    return FileType.all
      .filter { $0.type == type }
      .reduce(into: 0) { $0 = max(
        $0,
        $1.bytesCount ?? 0,
        $1.matchBytes?.reduce(into: 0) { $0 = max($0, $1.count) } ?? 0,
        $1.matchString?.reduce(into: 0) { $0 = max($0, $1.count) } ?? 0
        )}
  }
  
  static func getBytesCountFor(types: [FileTypeExtension]) -> Int {
    return FileType.all
      .filter { types.contains($0.type) }
      .reduce(into: 0) { $0 = max(
        $0,
        $1.bytesCount ?? 0,
        $1.matchBytes?.reduce(into: 0) { $0 = max($0, $1.count) } ?? 0,
        $1.matchString?.reduce(into: 0) { $0 = max($0, $1.count) } ?? 0
        )}
  }
  
  static func get(for data: Data) -> FileType? {
    for fileType in FileType.all {
      if fileType.bytesCount != nil && fileType.bytesCount! > data.count {
        continue
      }
      
      var isMatched: Bool = false
      
      if let matchString = fileType.matchString {
        if (matchString.contains(where: { data.starts(with: $0.utf8) })) {
          isMatched = true
        } else {
          continue
        }
      }
      
      if let matchBytes = fileType.matchBytes {
        if (matchBytes.contains(where: { data.starts(with: $0) })) {
          isMatched = true
        } else {
          continue
        }
      }
      
      if let match = fileType.match {
        if (match(data)) {
          isMatched = true
        } else {
          continue
        }
      }
      
      if (isMatched) {
        return fileType
      }
    }
    
    return nil
  }
}
