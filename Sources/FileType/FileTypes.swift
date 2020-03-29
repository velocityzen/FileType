import Foundation

public enum FileTypeExtension {
  case bmp
  case ac3
  case mp3
  case dmg
  case exe
  case ps
  case Z
  case jpg
  case jxr
  case gz
  case bz2
  case mpc
  case gif
  case flif
  case psd
  case aif
  case swf
  case zip
  case mid
  case dsf
  case lz
  case fla
  case bpg
  case wv
  case wasm
  case tif
  case ape
  case sql
  case nes
  case crx
  case cab
  case rpm
  case otf
  case amr
  case rtf
  case flv
  case it
  case xz
  case xml
  case ics
  case sevenz
  case rar
  case ble
  case arr
  case glb
  case orf
  case rw2
  case ktx
  case mie
  case mpg
  case ttf
  case ico
  case cur
  case raf
  case xm
  case voc
  case msi
  case mxf
  case lnk
  case ali
  case png
}

public struct FileType {
  let type: FileTypeExtension
  let ext: String
  let mime: String

  internal var matchString: [String]? = nil
  internal var matchBytes: [[UInt8]]? = nil
  internal var match: ((Data) -> Bool)? = nil
  internal var bytesCount: Int? = nil

  public static let all: [FileType] = [
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
    
    //ID3
//    FileType(
//      type: .mp3,
//      ext: "mp3",
//      mime: "audio/mpeg",
//      matchString: ["ID3"],
//      match: { data in
//        guard let fileData = skipID3Header(data) else {
//          return false
//        }
//
//        return matchPatterns(fileData, match: [[.byte(0x02)]], offset: 1, mask: [0x06])
//      }
//    ),

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

    FileType(
      type: .png,
      ext: "png",
      mime: "image/png",
      matchBytes: [[0x89, 0x50, 0x4E, 0x47]]
    ),

    //zip

    //ogg

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

    //ftyp

    FileType(
      type: .mid,
      ext: "mid",
      mime: "audio/midi",
      matchString: ["MThd"]
    ),

    // woff
    // woff2

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

    //pdf + ai

    FileType(
      type: .wasm,
      ext: "wasm",
      mime: "application/wasm",
      matchBytes: [[0x00, 0x61, 0x73, 0x6D]]
    ),

    // TIFF, little-endian types

    FileType(
      type: .tif,
      ext: "tif",
      mime: "image/tiff",
      matchBytes: [[0x4D, 0x4D, 0x0, 0x2A]]
    ),

    FileType(
      type: .ape,
      ext: "ape",
      mime: "audio/ape",
      matchString: ["MAC "]
    ),

    //matroska
    
    // RIFF file format which might be AVI, WAV, QCP, etc
    
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
    
    // MPEG program stream (PS or MPEG-PS)
    
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
    
    // deb & ar
    
    // png & apng
    
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
    
    // mov
    
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
    
    // ASF_Header_Object first 80 bytes
    
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
      match: {
        matchPatterns($0, match: [
          [.byte(0x7E), .byte(0x10), .byte(0x04), .any, .byte(0x30), .byte(0x4D), .byte(0x49), .byte(0x45)],
          [.byte(0x7E), .byte(0x18), .byte(0x04), .any, .byte(0x30), .byte(0x4D), .byte(0x49), .byte(0x45)]
        ])
      }
    ),
    
    // shp
    
    // JPEG-2000 family
    
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
    
    //tar
    
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
    
    //s3m
    
    // mts
    
    // mobi
    
    // dcm
    
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
    
    //eot
    
    // Increase sample size from 256 to 512
    
    // tar
    
    // Check for MPEG header at different starting offsets

  ]
}
