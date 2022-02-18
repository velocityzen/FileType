import Foundation

public struct FileType {
  public let type: FileTypeExtension
  public let ext: String
  public let mime: String
}

private extension FileType {
  static let all: [FileTypeMatchType: FileType] = [
    .asar: FileType(
        type: .asar,
        ext: "asar",
        mime: "application/x-asar"
    ),
    
    .bmp: FileType(
      type: .bmp,
      ext: "bmp",
      mime: "image/bmp"
    ),
    
    .ac3: FileType(
      type: .ac3,
      ext: "ac3",
      mime: "audio/vnd.dolby.dd-raw"
    ),
    
    .dmg: FileType(
      type: .dmg,
      ext: "dmg",
      mime: "application/x-apple-diskimage"
    ),
    
    .exe: FileType(
      type: .exe,
      ext: "exe",
      mime: "application/x-msdownload"
    ),
    
    .ps: FileType(
      type: .ps,
      ext: "ps",
      mime: "application/postscript"
    ),
    
    .Z: FileType(
      type: .Z,
      ext: "Z",
      mime: "application/x-compress"
    ),
    
    .jpg: FileType(
      type: .jpg,
      ext: "jpg",
      mime: "image/jpeg"
    ),
    
    .jxr: FileType(
      type: .jxr,
      ext: "jxr",
      mime: "image/vnd.ms-photo"
    ),
    
    .gz: FileType(
      type: .gz,
      ext: "gz",
      mime: "application/gzip"
    ),
    
    .bz2: FileType(
      type: .bz2,
      ext: "bz2",
      mime: "application/x-bzip2"
    ),
    
    .mpc: FileType(
      type: .mpc,
      ext: "mpc",
      mime: "audio/x-musepack"
    ),
    
    .gif: FileType(
      type: .gif,
      ext: "gif",
      mime: "image/gif"
    ),
    
    .flif: FileType(
      type: .flif,
      ext: "flif",
      mime: "image/flif"
    ),
    
    .psd: FileType(
      type: .psd,
      ext: "psd",
      mime: "image/vnd.adobe.photoshop"
    ),
        
    .aif: FileType(
      type: .aif,
      ext: "aif",
      mime: "audio/aiff"
    ),
    
    .swf: FileType(
      type: .swf,
      ext: "swf",
      mime: "application/x-shockwave-flash"
    ),
    
    .xpi: FileType(
      type: .xpi,
      ext: "xpi",
      mime: "application/x-xpinstall"
    ),
    
    .docx: FileType(
      type: .docx,
      ext: "docx",
      mime: "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    ),
    
    .pptx: FileType(
      type: .pptx,
      ext: "pptx",
      mime: "application/vnd.openxmlformats-officedocument.presentationml.presentation"
    ),
    
    .xlsx: FileType(
      type: .xlsx,
      ext: "xlsx",
      mime: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    ),
    
    .epub: FileType(
      type: .epub,
      ext: "epub",
      mime: "application/epub+zip"
    ),
    
    .odt: FileType(
      type: .odt,
      ext: "odt",
      mime: "application/vnd.oasis.opendocument.text"
    ),
    
    .ods: FileType(
      type: .ods,
      ext: "ods",
      mime: "application/vnd.oasis.opendocument.spreadsheet"
    ),
    
    .odp: FileType(
      type: .odp,
      ext: "odp",
      mime: "application/vnd.oasis.opendocument.presentation"
    ),
    
    .zip: FileType(
      type: .zip,
      ext: "zip",
      mime: "application/zip"
    ),
    
    .opus: FileType(
      type: .opus,
      ext: "opus",
      mime: "audio/opus"
    ),
    
    .ogv: FileType(
      type: .ogv,
      ext: "ogv",
      mime: "video/ogg"
    ),
    
    .ogm: FileType(
      type: .ogm,
      ext: "ogm",
      mime: "video/ogg"
    ),
    
    .oga: FileType(
      type: .oga,
      ext: "oga",
      mime: "audio/ogg"
    ),
    
    .spx: FileType(
      type: .spx,
      ext: "spx",
      mime: "audio/ogg"
    ),
    
    .ogg: FileType(
      type: .ogg,
      ext: "ogg",
      mime: "audio/ogg"
    ),
    
    .ogx: FileType(
      type: .ogx,
      ext: "ogx",
      mime: "application/ogg"
    ),
    
    .heif: FileType(
      type: .heic,
      ext: "heic",
      mime: "image/heif"
    ),
    
    .heifSequence: FileType(
      type: .heic,
      ext: "heic",
      mime: "image/heif-sequence"
    ),
    
    .heic: FileType(
      type: .heic,
      ext: "heic",
      mime: "image/heic"
    ),
    
    .heicSequence: FileType(
      type: .heic,
      ext: "heic",
      mime: "image/heic-sequence"
    ),
    
    .mov: FileType(
      type: .mov,
      ext: "mov",
      mime: "video/quicktime"
    ),
    
    .m4v: FileType(
      type: .m4v,
      ext: "m4v",
      mime: "video/x-m4v"
    ),
    
    .m4p: FileType(
      type: .m4p,
      ext: "m4p",
      mime: "video/mp4"
    ),
    
    .m4b: FileType(
      type: .m4b,
      ext: "m4b",
      mime: "audio/mp4"
    ),
    
    .m4a: FileType(
      type: .m4a,
      ext: "m4a",
      mime: "audio/x-m4a"
    ),
    
    .f4v: FileType(
      type: .f4v,
      ext: "f4v",
      mime: "video/mp4"
    ),
    
    .f4p: FileType(
      type: .f4p,
      ext: "f4p",
      mime: "video/mp4"
    ),
    
    .f4a: FileType(
      type: .f4a,
      ext: "f4a",
      mime: "audio/mp4"
    ),
    
    .f4b: FileType(
      type: .f4b,
      ext: "f4b",
      mime: "audio/mp4"
    ),
    
    .cr3: FileType(
      type: .cr3,
      ext: "cr3",
      mime: "image/x-canon-cr3"
    ),
    
    .threeg2: FileType(
      type: .threeg2,
      ext: "3g2",
      mime: "video/3gpp2"
    ),
    
    .threegp: FileType(
      type: .threegp,
      ext: "3gp",
      mime: "video/3gpp"
    ),
    
    .mp4: FileType(
      type: .mp4,
      ext: "mp4",
      mime: "video/mp4"
    ),
    
    .mid: FileType(
      type: .mid,
      ext: "mid",
      mime: "audio/midi"
    ),
    
    .woff: FileType(
      type: .woff,
      ext: "woff",
      mime: "font/woff"
    ),
    
    .woff2: FileType(
      type: .woff2,
      ext: "woff2",
      mime: "font/woff2"
    ),
    
    .dsf: FileType(
      type: .dsf,
      ext: "dsf",
      mime: "audio/x-dsf" // Non-standart
    ),
    
    .lz: FileType(
      type: .lz,
      ext: "lz",
      mime: "application/x-lzip"
    ),
    
    .flac: FileType(
      type: .flac,
      ext: "flac",
      mime: "audio/x-flac"
    ),
    
    .bpg: FileType(
      type: .bpg,
      ext: "bpg",
      mime: "image/bpg"
    ),
    
    .wv: FileType(
      type: .wv,
      ext: "wv",
      mime: "audio/wavpack"
    ),
    
    .ai: FileType(
      type: .ai,
      ext: "ai",
      mime: "application/postscript"
    ),
    
    .pdf: FileType(
      type: .pdf,
      ext: "pdf",
      mime: "application/pdf"
    ),
    
    .wasm: FileType(
      type: .wasm,
      ext: "wasm",
      mime: "application/wasm"
    ),
    
    .cr2: FileType(
      type: .cr2,
      ext: "cr2",
      mime: "image/x-canon-cr2"
    ),
    
    .nef: FileType(
      type: .nef,
      ext: "nef",
      mime: "image/x-nikon-nef"
    ),
    
    .dng: FileType(
      type: .dng,
      ext: "dng",
      mime: "image/x-adobe-dng"
    ),
    
    .arw: FileType(
      type: .arw,
      ext: "arw",
      mime: "image/x-sony-arw"
    ),
    
    .tif: FileType(
      type: .tif,
      ext: "tif",
      mime: "image/tiff"
    ),
    
    .ape: FileType(
      type: .ape,
      ext: "ape",
      mime: "audio/ape"
    ),
    
    .avi: FileType(
      type: .avi,
      ext: "avi",
      mime: "video/vnd.avi"
    ),
    
    .wav: FileType(
      type: .wav,
      ext: "wav",
      mime: "audio/vnd.wave"
    ),
    
    .qcp: FileType(
      type: .qcp,
      ext: "qcp",
      mime: "audio/qcelp"
    ),
    
    .sql: FileType(
      type: .sql,
      ext: "sqlite",
      mime: "application/x-sqlite3"
    ),
    
    .nes: FileType(
      type: .nes,
      ext: "nes",
      mime: "application/x-nintendo-nes-rom"
    ),
    
    .crx: FileType(
      type: .crx,
      ext: "crx",
      mime: "application/x-google-chrome-extension"
    ),
    
    .cab: FileType(
      type: .cab,
      ext: "cab",
      mime: "application/vnd.ms-cab-compressed"
    ),
    
    .rpm: FileType(
      type: .rpm,
      ext: "rpm",
      mime: "application/x-rpm"
    ),
    
    
    .otf: FileType(
      type: .otf,
      ext: "otf",
      mime: "font/otf"
    ),
    
    .amr: FileType(
      type: .amr,
      ext: "amr",
      mime: "audio/amr"
    ),
    
    .rtf: FileType(
      type: .rtf,
      ext: "rtf",
      mime: "application/rtf"
    ),
    
    .flv: FileType(
      type: .flv,
      ext: "flv",
      mime: "video/x-flv"
    ),
    
    .it: FileType(
      type: .it,
      ext: "it",
      mime: "audio/x-it"
    ),
    
    .mp1s: FileType(
      type: .mpg,
      ext: "mpg", // May also be .ps, .mpeg
      mime: "video/MP1S"
    ),
    
    .mp2p: FileType(
      type: .mpg,
      ext: "mpg", // May also be .mpg, .m2p, .vob or .sub
      mime: "video/MP2P"
    ),
    
    .xz: FileType(
      type: .xz,
      ext: "xz",
      mime: "application/x-xz"
    ),
    
    .xml: FileType(
      type: .xml,
      ext: "xml",
      mime: "application/xml"
    ),
    
    .ics: FileType(
      type: .ics,
      ext: "ics",
      mime: "text/calendar"
    ),
    
    .sevenz: FileType(
      type: .sevenz,
      ext: "7z",
      mime: "application/x-7z-compressed"
    ),
    
    .rar: FileType(
      type: .rar,
      ext: "rar",
      mime: "application/x-rar-compressed"
    ),
    
    .ble: FileType(
      type: .ble,
      ext: "blend",
      mime: "application/x-blender"
    ),
    
    .deb: FileType(
      type: .deb,
      ext: "deb",
      mime: "application/x-deb"
    ),
    
    .ar: FileType(
      type: .ar,
      ext: "ar",
      mime: "application/x-unix-archive"
    ),
    
    .apng: FileType(
      type: .apng,
      ext: "apng",
      mime: "image/apng"
    ),
    
    .png: FileType(
      type: .png,
      ext: "png",
      mime: "image/png"
    ),
    
    .arr: FileType(
      type: .arr,
      ext: "arrow",
      mime: "application/x-apache-arrow"
    ),
    
    .glb: FileType(
      type: .glb,
      ext: "glb",
      mime: "model/gltf-binary"
    ),
      
    .orf: FileType(
      type: .orf,
      ext: "orf",
      mime: "image/x-olympus-orf"
    ),
    
    .rw2: FileType(
      type: .rw2,
      ext: "rw2",
      mime: "image/x-panasonic-rw2"
    ),
    
    .wma: FileType(
      type: .wma,
      ext: "wma",
      mime: "audio/x-ms-wma"
    ),
    
    .wmv: FileType(
      type: .wmv,
      ext: "wmv",
      mime: "video/x-ms-asf"
    ),
    
    .asf: FileType(
      type: .asf,
      ext: "asf",
      mime: "application/vnd.ms-asf"
    ),
    
    .ktx: FileType(
      type: .ktx,
      ext: "ktx",
      mime: "image/ktx"
    ),
    
    .mie: FileType(
      type: .mie,
      ext: "mie",
      mime: "application/x-mie"
    ),
    
    .shp: FileType(
      type: .shp,
      ext: "shp",
      mime: "application/x-esri-shape"
    ),
    
    // JPEG-2000 family
    .jp2: FileType(
      type: .jp2,
      ext: "jp2",
      mime: "image/jp2"
    ),
    
    .jpx: FileType(
      type: .jpx,
      ext: "jpx",
      mime: "image/jpx"
    ),
    
    .jpm: FileType(
      type: .jpm,
      ext: "jpm",
      mime: "image/jpm"
    ),
    
    .mj2: FileType(
      type: .mj2,
      ext: "mj2",
      mime: "image/mj2"
    ),
    
    .mpg: FileType(
      type: .mpg,
      ext: "mpg",
      mime: "video/mpeg"
    ),
    
    .chm: FileType(
      type: .chm,
      ext: "chm",
      mime: "application/vnd.ms-htmlhelp"
    ),
    
    .ttf: FileType(
      type: .ttf,
      ext: "ttf",
      mime: "font/ttf"
    ),
    
    .ico: FileType(
      type: .ico,
      ext: "ico",
      mime: "image/x-icon"
    ),
    
    .icns: FileType(
      type: .icns,
      ext: "icns",
      mime: "image/icns"
    ),
    
    .cur: FileType(
      type: .cur,
      ext: "cur",
      mime: "image/x-icon"
    ),
    
    .raf: FileType(
      type: .raf,
      ext: "raf",
      mime: "image/x-fujifilm-raf"
    ),
    
    .xm: FileType(
      type: .xm,
      ext: "xm",
      mime: "audio/x-xm"
    ),
    
    .voc: FileType(
      type: .voc,
      ext: "voc",
      mime: "audio/x-voc"
    ),
    
    .msi: FileType(
      type: .msi,
      ext: "msi",
      mime: "application/x-msi"
    ),
    
    .mxf: FileType(
      type: .mxf,
      ext: "mxf",
      mime: "application/mxf"
    ),
    
    .s3m: FileType(
      type: .s3m,
      ext: "s3m",
      mime: "audio/x-s3m"
    ),
    
    .mts: FileType(
      type: .mts,
      ext: "mts",
      mime: "video/mp2t"
    ),
    
    .mobi: FileType(
      type: .mobi,
      ext: "mobi",
      mime: "application/x-mobipocket-ebook"
    ),
    
    .dcm: FileType(
      type: .dcm,
      ext: "dcm",
      mime: "application/dicom"
    ),
    
    .lnk: FileType(
      type: .lnk,
      ext: "lnk",
      mime: "application/x.ms.shortcut" // Invented by u
    ),
    
    .ali: FileType(
      type: .ali,
      ext: "alias",
      mime: "application/x.apple.alias" // Invented by us
    ),
    
    .eot: FileType(
      type: .eot,
      ext: "eot",
      mime: "application/vnd.ms-fontobject"
    ),
    
    .tar: FileType(
      type: .tar,
      ext: "tar",
      mime: "application/x-tar"
    ),
    
    .aac: FileType(
      type: .aac,
      ext: "aac",
      mime: "audio/aac"
    ),
      
    .mp2: FileType(
      type: .mp2,
      ext: "mp2",
      mime: "audio/mpeg"
    ),
    
    .mp1: FileType(
      type: .mp1,
      ext: "mp1",
      mime: "audio/mpeg"
    ),
    
    .mp3: FileType(
      type: .mp3,
      ext: "mp3",
      mime: "audio/mpeg"
    ),
    
    .pgp: FileType(
      type: .pgp,
      ext: "pgp",
      mime: "application/pgp-encrypted"
    ),
    
    .lzh: FileType(
      type: .lzh,
      ext: "lzh",
      mime: "application/x-lzh-compressed"
    ),
    
    .skp: FileType(
      type: .skp,
      ext: "skp",
      mime: "application/vnd.sketchup.skp"
    ),
    
    .avif: FileType(
      type: .avif,
      ext: "avif",
      mime: "image/avif"
    ),
    
    .eps: FileType(
      type: .eps,
      ext: "eps",
      mime: "application/eps"
    ),
    
    .indd: FileType(
      type: .indd,
      ext: "indd",
      mime: "application/x-indesign"
    )
  ]
}

public extension FileType {
  static func getBytesCountFor(type: FileTypeExtension) -> Int {
    return FileTypeMatch.all
      .filter { FileType.all[$0.type]?.type == type }
      .reduce(into: 0) { $0 = max(
        $0,
        $1.bytesCount ?? 0,
        $1.matchBytes?.reduce(into: 0) { $0 = max($0, $1.count) } ?? 0,
        $1.matchString?.reduce(into: 0) { $0 = max($0, $1.count) } ?? 0
      )}
  }
  
  static func getBytesCountFor(types: [FileTypeExtension]) -> Int {
    return FileTypeMatch.all
      .filter { types.contains(FileType.all[$0.type]!.type) }
      .reduce(into: 0) { $0 = max(
        $0,
        $1.bytesCount ?? 0,
        $1.matchBytes?.reduce(into: 0) { $0 = max($0, $1.count) } ?? 0,
        $1.matchString?.reduce(into: 0) { $0 = max($0, $1.count) } ?? 0
      )}
  }
  
  static func getFor(type: FileTypeExtension) -> [FileType] {
    return FileType.all
      .filter{ (key, value) in
        value.type == type
      }
      .map { (key, value) in value }
  }
  
  static func getFor(data: Data) -> FileType? {
    for fileTypeMatch in FileTypeMatch.all {
      if fileTypeMatch.bytesCount != nil && fileTypeMatch.bytesCount! > data.count {
        continue
      }
      
      var isMatched: Bool = false
      
      if let matchString = fileTypeMatch.matchString {
        if (matchString.contains(where: { data.starts(with: $0.utf8) })) {
          isMatched = true
        } else {
          continue
        }
      }
      
      if let matchBytes = fileTypeMatch.matchBytes {
        if (matchBytes.contains(where: { data.starts(with: $0) })) {
          isMatched = true
        } else {
          continue
        }
      }
      
      if let match = fileTypeMatch.match {
        if (match(data)) {
          isMatched = true
        } else {
          continue
        }
      }
      
      if (isMatched) {
        return FileType.all[fileTypeMatch.type]
      }
    }
    
    return nil
  }
}
