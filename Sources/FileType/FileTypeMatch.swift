import Foundation

enum FileTypeMatchType {
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
  case flac
  case flif
  case flv
  case gif
  case glb
  case gz
  case heif
  case heifSequence
  case heic
  case heicSequence
  case ico
  case ics
  case icns
  case it
  case jp2
  case jpg
  case jpm
  case jpx
  case jxr
  case ktx
  case lnk
  case lz
  case lzh
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
  case mp1s
  case mp2p
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
  case pgp
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
  case skp
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

struct FileTypeMatch {
  let type: FileTypeMatchType
  
  var bytesCount: Int? = nil
  var matchString: [String]? = nil
  var matchBytes: [[UInt8]]? = nil
  var match: ((Data) -> Bool)? = nil
  
  static let all: [FileTypeMatch] = [
    FileTypeMatch(
      type: .bmp,
      matchBytes: [[0x42, 0x4D]]
    ),
    
    FileTypeMatch(
      type: .ac3,
      matchBytes: [[0x0B, 0x77]]
    ),
    
    FileTypeMatch(
      type: .dmg,
      matchBytes: [[0x78, 0x01]]
    ),
    
    FileTypeMatch(
      type: .exe,
      matchBytes: [[0x4D, 0x5A]]
    ),
    
    FileTypeMatch(
      type: .ps,
      matchBytes: [[0x25, 0x21]]
    ),
    
    FileTypeMatch(
      type: .Z,
      matchBytes: [[0x1F, 0xA0], [0x1F, 0x9D]]
    ),
    
    FileTypeMatch(
      type: .jpg,
      matchBytes: [[0xFF, 0xD8, 0xFF]]
    ),
    
    FileTypeMatch(
      type: .jxr,
      matchBytes: [[0x49, 0x49, 0xBC]]
    ),
    
    FileTypeMatch(
      type: .gz,
      matchBytes: [[0x1F, 0x8B, 0x8]]
    ),
    
    FileTypeMatch(
      type: .bz2,
      matchBytes: [[0x42, 0x5A, 0x68]]
    ),
    
    FileTypeMatch(
      type: .mpc,
      matchString: ["MP+"]
    ),
    
    FileTypeMatch(
      type: .gif,
      matchBytes: [[0x47, 0x49, 0x46]]
    ),
    
    FileTypeMatch(
      type: .flif,
      matchString: ["FLIF"]
    ),
    
    FileTypeMatch(
      type: .psd,
      matchString: ["8BPS"]
    ),
    
    FileTypeMatch(
      type: .mpc,
      matchString: ["MPCK"]
    ),
    
    FileTypeMatch(
      type: .aif,
      matchString: ["FORM"]
    ),
    
    FileTypeMatch(
      type: .swf,
      matchBytes: [[0x43, 0x57, 0x53], [0x46, 0x57, 0x53]]
    ),
    
    FileTypeMatch(
      type: .icns,
      matchString: ["icns"]
    ),
    
    // Zip-based file formats
    FileTypeMatch(
      type: .xpi,
      matchBytes: [[0x50, 0x4B, 0x3, 0x4]],
      match: { matchZipHeader($0) { $0.filename == "META-INF/mozilla.rsa" }}
    ),
    
    FileTypeMatch(
      type: .docx,
      matchBytes: [[0x50, 0x4B, 0x3, 0x4]],
      match: { matchZipHeader($0) {
        matchMSOffice($0, type: "word")
        }}
    ),
    
    FileTypeMatch(
      type: .pptx,
      matchBytes: [[0x50, 0x4B, 0x3, 0x4]],
      match: { matchZipHeader($0) { matchMSOffice($0, type: "ppt") }}
    ),
    
    FileTypeMatch(
      type: .xlsx,
      matchBytes: [[0x50, 0x4B, 0x3, 0x4]],
      match: { matchZipHeader($0) { matchMSOffice($0, type: "xl", startsWith: "xl/") }}
    ),
    
    FileTypeMatch(
      type: .epub,
      matchBytes: [[0x50, 0x4B, 0x3, 0x4]],
      match: { matchZipHeader($0) { $0.mimeType == "application/epub+zip" }}
    ),
    
    FileTypeMatch(
      type: .odt,
      matchBytes: [[0x50, 0x4B, 0x3, 0x4]],
      match: { matchZipHeader($0) { $0.mimeType == "application/vnd.oasis.opendocument.text" }}
    ),
    
    FileTypeMatch(
      type: .ods,
      matchBytes: [[0x50, 0x4B, 0x3, 0x4]],
      match: { matchZipHeader($0) { $0.mimeType == "application/vnd.oasis.opendocument.spreadsheet" }}
    ),
    
    FileTypeMatch(
      type: .odp,
      matchBytes: [[0x50, 0x4B, 0x3, 0x4]],
      match: { matchZipHeader($0) { $0.mimeType == "application/vnd.oasis.opendocument.presentation" }}
    ),
    
    FileTypeMatch(
      type: .zip,
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
    FileTypeMatch(
      type: .opus,
      bytesCount: 36,
      matchString: ["OggS"],
      match: { matchPatterns($0, match: [
        [
          .byte(0x4F), .byte(0x70), .byte(0x75), .byte(0x73),
          .byte(0x48), .byte(0x65), .byte(0x61), .byte(0x64)
        ]
      ], offset: 28) }
    ),
    
    FileTypeMatch(
      type: .ogv,
      bytesCount: 35,
      matchString: ["OggS"],
      match: { matchPatterns($0, match: [
        [
          .byte(0x80), .byte(0x74), .byte(0x68), .byte(0x65),
          .byte(0x6F), .byte(0x72), .byte(0x61)
        ]
      ], offset: 28) }
    ),
    
    FileTypeMatch(
      type: .ogm,
      bytesCount: 35,
      matchString: ["OggS"],
      match: { matchPatterns($0, match: [
        [
          .byte(0x01), .byte(0x76), .byte(0x69), .byte(0x64),
          .byte(0x65), .byte(0x6F), .byte(0x00)
        ]
      ], offset: 28) }
    ),
    
    FileTypeMatch(
      type: .oga,
      bytesCount: 33,
      matchString: ["OggS"],
      match: { matchPatterns($0, match: [
        [
          .byte(0x7F), .byte(0x46), .byte(0x4C), .byte(0x41),
          .byte(0x43)
        ]
      ], offset: 28) }
    ),
    
    FileTypeMatch(
      type: .spx,
      bytesCount: 35,
      matchString: ["OggS"],
      match: { matchPatterns($0, match: [
        [
          .byte(0x53), .byte(0x70), .byte(0x65), .byte(0x65),
          .byte(0x78), .byte(0x20), .byte(0x20)
        ]
      ], offset: 28) }
    ),
    
    FileTypeMatch(
      type: .ogg,
      bytesCount: 35,
      matchString: ["OggS"],
      match: { matchPatterns($0, match: [
        [
          .byte(0x01), .byte(0x76), .byte(0x6F), .byte(0x72),
          .byte(0x62), .byte(0x69), .byte(0x73)
        ]
      ], offset: 28) }
    ),
    
    FileTypeMatch(
      type: .ogx,
      matchString: ["OggS"]
    ),
    
    //File Type Box Formats
    FileTypeMatch(
      type: .heif,
      bytesCount: 12,
      match: { matchPatterns($0, match: [
        [
          .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
          .byte(0x6D), .byte(0x69), .byte(0x66), .byte(0x31)  // mif1
        ]
      ], offset: 4) }
    ),
    
    FileTypeMatch(
      type: .heifSequence,
      bytesCount: 12,
      match: { matchPatterns($0, match: [
        [
          .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
          .byte(0x6D), .byte(0x73), .byte(0x66), .byte(0x31)  // msf1
        ]
      ], offset: 4) }
    ),
    
    FileTypeMatch(
      type: .heic,
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
    
    FileTypeMatch(
      type: .heicSequence,
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
    
    FileTypeMatch(
      type: .mov,
      bytesCount: 10,
      match: { matchPatterns($0, match: [
        [
          .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
          .byte(0x71), .byte(0x74)                            // qt
        ]
      ], offset: 4) }
    ),
    
    FileTypeMatch(
      type: .m4v,
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
    
    FileTypeMatch(
      type: .m4p,
      bytesCount: 11,
      match: { matchPatterns($0, match: [[
        .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
        .byte(0x4d), .byte(0x34), .byte(0x50)               // M4P
        ]], offset: 4) }
    ),
    
    FileTypeMatch(
      type: .m4b,
      bytesCount: 11,
      match: { matchPatterns($0, match: [[
        .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
        .byte(0x4d), .byte(0x34), .byte(0x42)               // M4B
        ]], offset: 4) }
    ),
    
    FileTypeMatch(
      type: .m4a,
      bytesCount: 11,
      match: { matchPatterns($0, match: [[
        .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
        .byte(0x4d), .byte(0x34), .byte(0x41)               // M4A
        ]], offset: 4) }
    ),
    
    FileTypeMatch(
      type: .f4v,
      bytesCount: 11,
      match: { matchPatterns($0, match: [[
        .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
        .byte(0x46), .byte(0x34), .byte(0x56)               // F4V
        ]], offset: 4) }
    ),
    
    FileTypeMatch(
      type: .f4p,
      bytesCount: 11,
      match: { matchPatterns($0, match: [[
        .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
        .byte(0x46), .byte(0x34), .byte(0x50)               // F4P
        ]], offset: 4) }
    ),
    
    FileTypeMatch(
      type: .f4a,
      bytesCount: 11,
      match: { matchPatterns($0, match: [[
        .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
        .byte(0x46), .byte(0x34), .byte(0x41)               // F4A
        ]], offset: 4) }
    ),
    
    FileTypeMatch(
      type: .f4b,
      bytesCount: 11,
      match: { matchPatterns($0, match: [[
        .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
        .byte(0x46), .byte(0x34), .byte(0x42)               // F4B
        ]], offset: 4) }
    ),
    
    FileTypeMatch(
      type: .cr3,
      bytesCount: 11,
      match: { matchPatterns($0, match: [[
        .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
        .byte(0x63), .byte(0x72), .byte(0x78)               // crx
        ]], offset: 4) }
    ),
    
    FileTypeMatch(
      type: .threeg2,
      bytesCount: 11,
      match: { matchPatterns($0, match: [[
        .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
        .byte(0x33), .byte(0x67), .byte(0x32)               // 3g2
        ]], offset: 4) }
    ),
    
    FileTypeMatch(
      type: .threegp,
      bytesCount: 10,
      match: { matchPatterns($0, match: [[
        .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
        .byte(0x33), .byte(0x67)                            // 3g
        ]], offset: 4) }
    ),
    
    FileTypeMatch(
      type: .mp4,
      bytesCount: 8,
      match: { matchPatterns($0, match: [[
        .byte(0x66), .byte(0x74), .byte(0x79), .byte(0x70), // ftyp
        ]], offset: 4) }
    ),
    
    
    FileTypeMatch(
      type: .mid,
      matchString: ["MThd"]
    ),
    
    FileTypeMatch(
      type: .woff,
      bytesCount: 12,
      matchString: ["wOFF"],
      match: {
        matchPatterns($0, match: [
          [.byte(0x0), .byte(0x01), .byte(0x0), .byte(0x0)],
          [.byte(0x4F), .byte(0x54), .byte(0x54), .byte(0x4F)]
        ], offset: 4)
    }
    ),
    
    FileTypeMatch(
      type: .woff2,
      bytesCount: 12,
      matchString: ["wOF2"],
      match: {
        matchPatterns($0, match: [
          [.byte(0x00), .byte(0x01), .byte(0x0), .byte(0x00)],
          [.byte(0x4F), .byte(0x54), .byte(0x54), .byte(0x4F)]
        ], offset: 4)
    }
    ),
    
    FileTypeMatch(
      type: .dsf,
      matchString: ["DSD "]
    ),
    
    FileTypeMatch(
      type: .lz,
      matchString: ["LZIP"]
    ),
    
    FileTypeMatch(
      type: .flac,
      matchString: ["fLaC"]
    ),
    
    FileTypeMatch(
      type: .bpg,
      matchBytes: [[0x42, 0x50, 0x47, 0xFB]]
    ),
    
    FileTypeMatch(
      type: .wv,
      matchString: ["wvpk"]
    ),
    
    FileTypeMatch(
      type: .ai,
      matchString: ["%PDF"],
      match: { findString($0, "Adobe Illustrator", ignore: 1350) }
    ),
    
    FileTypeMatch(
      type: .pdf,
      matchString: ["%PDF"]
    ),
    
    FileTypeMatch(
      type: .wasm,
      matchBytes: [[0x00, 0x61, 0x73, 0x6D]]
    ),
    
    // tiff, little-endian type based file formats
    FileTypeMatch(
      type: .cr2,
      bytesCount: 10,
      matchBytes: [[0x49, 0x49, 0x2A, 0x0]],
      match: {
        matchPatterns($0, match: [[.byte(0x43), .byte(0x52)]], offset: 8)
    }
    ),
    
    FileTypeMatch(
      type: .nef,
      bytesCount: 12,
      matchBytes: [[0x49, 0x49, 0x2A, 0x0]],
      match: {
        matchPatterns($0, match: [
          [.byte(0x1C), .byte(0x0), .byte(0xFE), .byte(0x0)],
          [.byte(0x1F), .byte(0x0), .byte(0x0B), .byte(0x0)]
        ], offset: 8)
    }
    ),
    
    FileTypeMatch(
      type: .dng,
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
    
    FileTypeMatch(
      type: .arw,
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
    
    FileTypeMatch(
      type: .tif,
      matchBytes: [
        [0x49, 0x49, 0x2A, 0x0],
        [0x4D, 0x4D, 0x0, 0x2A]
      ]
    ),
    
    FileTypeMatch(
      type: .ape,
      matchString: ["MAC "]
    ),
    
    //matroska
    
    FileTypeMatch(
      type: .avi,
      bytesCount: 11,
      matchBytes: [[0x52, 0x49, 0x46, 0x46]],
      match: {
        matchPatterns($0, match: [
          [.byte(0x41), .byte(0x56), .byte(0x49)]
        ], offset: 8)
    }
    ),
    
    FileTypeMatch(
      type: .wav,
      bytesCount: 12,
      matchBytes: [[0x52, 0x49, 0x46, 0x46]],
      match: {
        matchPatterns($0, match: [
          [.byte(0x57), .byte(0x41), .byte(0x56), .byte(0x45)]
        ], offset: 8)
    }
    ),
    
    FileTypeMatch(
      type: .qcp,
      bytesCount: 12,
      matchBytes: [[0x52, 0x49, 0x46, 0x46]],
      match: {
        matchPatterns($0, match: [
          [.byte(0x51), .byte(0x4C), .byte(0x43), .byte(0x4D)]
        ], offset: 8)
    }
    ),
    
    FileTypeMatch(
      type: .sql,
      matchString: ["SQLi"]
    ),
    
    FileTypeMatch(
      type: .nes,
      matchBytes: [[0x4E, 0x45, 0x53, 0x1A]]
    ),
    
    FileTypeMatch(
      type: .crx,
      matchString: ["Cr24"]
    ),
    
    FileTypeMatch(
      type: .cab,
      matchString: ["MSCF", "ISc("]
    ),
    
    FileTypeMatch(
      type: .rpm,
      matchBytes: [[0xED, 0xAB, 0xEE, 0xDB]]
    ),
    
    // -- 5-byte signatures --
    
    FileTypeMatch(
      type: .otf,
      matchBytes: [[0x4F, 0x54, 0x54, 0x4F, 0x00]]
    ),
    
    FileTypeMatch(
      type: .amr,
      matchString: ["#!AMR"]
    ),
    
    FileTypeMatch(
      type: .rtf,
      matchString: ["{\\rtf"]
    ),
    
    FileTypeMatch(
      type: .flv,
      matchBytes: [[0x46, 0x4C, 0x56, 0x01]]
    ),
    
    FileTypeMatch(
      type: .it,
      matchString: ["IMPM"]
    ),
    
    FileTypeMatch(
      type: .lzh,
      bytesCount: 7,
      match: {
        matchPatterns($0, match: [
          [ .byte(0x2d), .byte(0x6c), .byte(0x68), .byte(0x30), .byte(0x2d) ],
          [ .byte(0x2d), .byte(0x6c), .byte(0x68), .byte(0x31), .byte(0x2d) ],
          [ .byte(0x2d), .byte(0x6c), .byte(0x68), .byte(0x32), .byte(0x2d) ],
          [ .byte(0x2d), .byte(0x6c), .byte(0x68), .byte(0x33), .byte(0x2d) ],
          [ .byte(0x2d), .byte(0x6c), .byte(0x68), .byte(0x34), .byte(0x2d) ],
          [ .byte(0x2d), .byte(0x6c), .byte(0x68), .byte(0x35), .byte(0x2d) ],
          [ .byte(0x2d), .byte(0x6c), .byte(0x68), .byte(0x36), .byte(0x2d) ],
          [ .byte(0x2d), .byte(0x6c), .byte(0x68), .byte(0x37), .byte(0x2d) ],
          [ .byte(0x2d), .byte(0x6c), .byte(0x68), .byte(0x64), .byte(0x2d) ],
          [ .byte(0x2d), .byte(0x6c), .byte(0x7a), .byte(0x73), .byte(0x2d) ],
          [ .byte(0x2d), .byte(0x6c), .byte(0x7a), .byte(0x34), .byte(0x2d) ],
          [ .byte(0x2d), .byte(0x6c), .byte(0x7a), .byte(0x35), .byte(0x2d) ],
        ], offset: 2)
    }
    ),
    
    //  MPEG-PS, MPEG-1 Part 1
    FileTypeMatch(
      type: .mpg,
      bytesCount: 5,
      matchBytes: [[0x00, 0x00, 0x01, 0xBA]],
      match: {
        matchPatterns($0, match: [[.byte(0x21)]], offset: 4, mask: [0xF1])
    }
    ),
    
    // MPEG-PS, MPEG-2 Part 1
    FileTypeMatch(
      type: .mpg,
      bytesCount: 5,
      matchBytes: [[0x00, 0x00, 0x01, 0xBA]],
      match: {
        matchPatterns($0, match: [[.byte(0x44)]], offset: 4, mask: [0xC4])
    }
    ),
    
    FileTypeMatch(
      type: .xz,
      matchBytes: [[0xFD, 0x37, 0x7A, 0x58, 0x5A, 0x00]]
    ),
    
    FileTypeMatch(
      type: .xml,
      matchString: ["<?xml "]
    ),
    
    FileTypeMatch(
      type: .ics,
      matchString: ["BEGIN:"]
    ),
    
    FileTypeMatch(
      type: .sevenz,
      matchBytes: [[0x37, 0x7A, 0xBC, 0xAF, 0x27, 0x1C]]
    ),
    
    FileTypeMatch(
      type: .rar,
      matchBytes: [
        [0x52, 0x61, 0x72, 0x21, 0x1A, 0x7, 0x0],
        [0x52, 0x61, 0x72, 0x21, 0x1A, 0x7, 0x1]
      ]
    ),
    
    // -- 7-byte signatures --
    
    FileTypeMatch(
      type: .ble,
      matchString: ["BLENDER"]
    ),
    
    FileTypeMatch(
      type: .deb,
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
    
    FileTypeMatch(
      type: .ar,
      matchString: ["!<arch>"]
    ),
    
    FileTypeMatch(
      type: .apng,
      bytesCount: 32,
      matchBytes: [[0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]],
      match: findAPNG
    ),
    
    FileTypeMatch(
      type: .png,
      matchBytes: [[0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]]
    ),
    
    FileTypeMatch(
      type: .arr,
      matchBytes: [[0x41, 0x52, 0x52, 0x4F, 0x57, 0x31, 0x00, 0x00]]
    ),
    
    FileTypeMatch(
      type: .glb,
      matchBytes: [[0x67, 0x6C, 0x54, 0x46, 0x02, 0x00, 0x00, 0x00]]
    ),
    
    FileTypeMatch(
      type: .mov,
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
    
    FileTypeMatch(
      type: .orf,
      matchBytes: [[0x49, 0x49, 0x52, 0x4F, 0x08, 0x00, 0x00, 0x00, 0x18]]
    ),
    
    // -- 12-byte signatures --
    
    FileTypeMatch(
      type: .rw2,
      matchBytes: [[0x49, 0x49, 0x55, 0x00, 0x18, 0x00, 0x00, 0x00, 0x88, 0xE7, 0x74, 0xD8]]
    ),
    
    FileTypeMatch(
      type: .wma,
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
    
    FileTypeMatch(
      type: .wmv,
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
    
    FileTypeMatch(
      type: .asf,
      matchBytes: [[
        0x30, 0x26, 0xB2, 0x75,
        0x8E, 0x66, 0xCF, 0x11,
        0xA6, 0xD9
        ]]
    ),
    
    FileTypeMatch(
      type: .ktx,
      matchBytes: [[0xAB, 0x4B, 0x54, 0x58, 0x20, 0x31, 0x31, 0xBB, 0x0D, 0x0A, 0x1A, 0x0A]]
    ),
    
    FileTypeMatch(
      type: .mie,
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
    
    FileTypeMatch(
      type: .shp,
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
    FileTypeMatch(
      type: .jp2,
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
    
    FileTypeMatch(
      type: .jpx,
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
    
    FileTypeMatch(
      type: .jpm,
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
    
    FileTypeMatch(
      type: .mj2,
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
    FileTypeMatch(
      type: .mpg,
      matchBytes: [[0x0, 0x0, 0x1, 0xBA], [0x0, 0x0, 0x1, 0xB3]]
    ),
    
    FileTypeMatch(
      type: .ttf,
      matchBytes: [[0x00, 0x01, 0x00, 0x00, 0x00]]
    ),
    
    FileTypeMatch(
      type: .ico,
      matchBytes: [[0x00, 0x00, 0x01, 0x00]]
    ),
    
    FileTypeMatch(
      type: .cur,
      matchBytes: [[0x00, 0x00, 0x02, 0x00]]
    ),
    
    // Increase sample size from 12 to 256.
    
    // `raf` is here just to keep all the raw image detectors together.
    FileTypeMatch(
      type: .raf,
      matchString: ["FUJIFILMCCD-RAW"]
    ),
    
    FileTypeMatch(
      type: .xm,
      matchString: ["Extended Module:"]
    ),
    
    FileTypeMatch(
      type: .pgp,
      matchString: ["-----BEGIN PGP MESSAGE-----"]
    ),
    
    FileTypeMatch(
      type: .voc,
      matchString: ["Creative Voice File"]
    ),
    
    FileTypeMatch(
      type: .msi,
      matchBytes: [[0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3E]]
    ),
    
    FileTypeMatch(
      type: .mxf,
      matchBytes: [[0x06, 0x0E, 0x2B, 0x34, 0x02, 0x05, 0x01, 0x01, 0x0D, 0x01, 0x02, 0x01, 0x01, 0x02]]
    ),
    
    FileTypeMatch(
      type: .s3m,
      bytesCount: 44 + 4,
      match: { matchPatterns($0, match: [
        [.byte(0x53), .byte(0x43), .byte(0x52), .byte(0x4D)]
      ], offset: 44)}
    ),
    
    FileTypeMatch(
      type: .mts,
      bytesCount: 197,
      match: {
        matchPatterns($0, match: [[.byte(0x47)]], offset: 4) &&
          (
            matchPatterns($0, match: [[.byte(0x47)]], offset: 192) ||
              matchPatterns($0, match: [[.byte(0x47)]], offset: 196)
        )
    }
    ),
    
    FileTypeMatch(
      type: .mobi,
      bytesCount: 60 + 8,
      match: { matchPatterns($0, match: [
        [
          .byte(0x42), .byte(0x4F), .byte(0x4F), .byte(0x4B),
          .byte(0x4D), .byte(0x4F), .byte(0x42), .byte(0x49)
        ]
      ], offset: 60)}
    ),
    
    FileTypeMatch(
      type: .dcm,
      bytesCount: 128 + 4,
      match: { matchPatterns($0, match: [
        [.byte(0x44), .byte(0x49), .byte(0x43), .byte(0x4D)]
      ], offset: 128)}
    ),
    
    FileTypeMatch(
      type: .lnk,
      matchBytes: [[0x4C, 0x00, 0x00, 0x00, 0x01, 0x14, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]]
    ),
    
    FileTypeMatch(
      type: .ali,
      matchBytes: [[0x62, 0x6F, 0x6F, 0x6B, 0x00, 0x00, 0x00, 0x00, 0x6D, 0x61, 0x72, 0x6B, 0x00, 0x00, 0x00, 0x00]]
    ),
    
    FileTypeMatch(
      type: .eot,
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
    
    FileTypeMatch(
      type: .tar,
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
    
    FileTypeMatch(
      type: .skp,
      matchBytes: [[
        0xFF, 0xFE, 0xFF, 0x0E, 0x53, 0x00, 0x6B, 0x00,
        0x65, 0x00, 0x74, 0x00, 0x63, 0x00, 0x68, 0x00,
        0x55, 0x00, 0x70, 0x00, 0x20, 0x00, 0x4D, 0x00,
        0x6F, 0x00, 0x64, 0x00, 0x65, 0x00, 0x6C, 0x00
      ]]
    ),
    
    FileTypeMatch(
      type: .aac,
      bytesCount: 18,
      match: { matchMPEGHeader($0, match: 0x10, mask: 0x16) }
    ),
    
    FileTypeMatch(
      type: .mp3,
      bytesCount: 18,
      match: { matchMPEGHeader($0, match: 0x02, mask: 0x06) }
    ),
    
    FileTypeMatch(
      type: .mp2,
      bytesCount: 18,
      match: { matchMPEGHeader($0, match: 0x04, mask: 0x06) }
    ),
    
    FileTypeMatch(
      type: .mp1,
      bytesCount: 18,
      match: { matchMPEGHeader($0, match: 0x06, mask: 0x06) }
    ),
    
    FileTypeMatch(
      type: .mp3,
      matchString: ["ID3"]
    ),
    
  ]

}
