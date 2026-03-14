import Foundation

public enum FileTypeDataRequirement: Sendable, Hashable {
    case prefix(Int)
    case fullFile
}

public struct FileType: Hashable, Sendable {
    public let type: FileTypeExtension
    public let ext: String
    public let mime: String
}

extension FileType {
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

        .threemf: FileType(
            type: .threemf,
            ext: "3mf",
            mime: "model/3mf"
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

        .mpd: FileType(
            type: .mpd,
            ext: "mpd",
            mime: "video/vnd.mpeg.dash.mpd"
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
            mime: "audio/x-dsf"  // Non-standard
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
            ext: "mpg",  // May also be .ps, .mpeg
            mime: "video/MP1S"
        ),

        .mp2p: FileType(
            type: .mpg,
            ext: "mpg",  // May also be .mpg, .m2p, .vob or .sub
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

        .ism: FileType(
            type: .ism,
            ext: "ism",
            mime: "application/vnd.ms-sstr+xml"
        ),

        .vcf: FileType(
            type: .vcf,
            ext: "vcf",
            mime: "text/vcard"
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

        .stl: FileType(
            type: .stl,
            ext: "stl",
            mime: "model/stl"
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

        .xcf: FileType(
            type: .xcf,
            ext: "xcf",
            mime: "image/x-xcf"
        ),

        .rw2: FileType(
            type: .rw2,
            ext: "rw2",
            mime: "image/x-panasonic-rw2"
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

        .jxl: FileType(
            type: .jxl,
            ext: "jxl",
            mime: "image/jxl"
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

        .cfb: FileType(
            type: .cfb,
            ext: "cfb",
            mime: "application/x-cfb"
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
            mime: "application/x.ms.shortcut"  // Invented by us
        ),

        .ali: FileType(
            type: .ali,
            ext: "alias",
            mime: "application/x.apple.alias"  // Invented by us
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

        .m3u: FileType(
            type: .m3u,
            ext: "m3u",
            mime: "application/vnd.apple.mpegurl"
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

        .zst: FileType(
            type: .zst,
            ext: "zst",
            mime: "application/zstd"
        ),

        .indd: FileType(
            type: .indd,
            ext: "indd",
            mime: "application/x-indesign"
        ),

        .elf: FileType(
            type: .elf,
            ext: "elf",
            mime: "application/x-elf"
        ),

        .mkv: FileType(
            type: .mkv,
            ext: "mkv",
            mime: "video/x-matroska"
        ),

        .webm: FileType(
            type: .webm,
            ext: "webm",
            mime: "video/webm"
        ),

        .ace: FileType(
            type: .ace,
            ext: "ace",
            mime: "application/x-ace-compressed"
        ),

        .apk: FileType(
            type: .apk,
            ext: "apk",
            mime: "application/vnd.android.package-archive"
        ),

        .arj: FileType(
            type: .arj,
            ext: "arj",
            mime: "application/x-arj"
        ),

        .avro: FileType(
            type: .avro,
            ext: "avro",
            mime: "application/avro"
        ),

        .cpio: FileType(
            type: .cpio,
            ext: "cpio",
            mime: "application/x-cpio"
        ),

        .dat: FileType(
            type: .dat,
            ext: "dat",
            mime: "application/x-ft-windows-registry-hive"
        ),

        .docm: FileType(
            type: .docm,
            ext: "docm",
            mime: "application/vnd.ms-word.document.macroenabled.12"
        ),

        .dotm: FileType(
            type: .dotm,
            ext: "dotm",
            mime: "application/vnd.ms-word.template.macroenabled.12"
        ),

        .dotx: FileType(
            type: .dotx,
            ext: "dotx",
            mime: "application/vnd.openxmlformats-officedocument.wordprocessingml.template"
        ),

        .drc: FileType(
            type: .drc,
            ext: "drc",
            mime: "application/vnd.google.draco"
        ),

        .dwg: FileType(
            type: .dwg,
            ext: "dwg",
            mime: "image/vnd.dwg"
        ),

        .fbx: FileType(
            type: .fbx,
            ext: "fbx",
            mime: "application/x.autodesk.fbx"
        ),

        .icc: FileType(
            type: .icc,
            ext: "icc",
            mime: "application/vnd.iccprofile"
        ),

        .j2c: FileType(
            type: .j2c,
            ext: "j2c",
            mime: "image/j2c"
        ),

        .jar: FileType(
            type: .jar,
            ext: "jar",
            mime: "application/java-archive"
        ),

        .jls: FileType(
            type: .jls,
            ext: "jls",
            mime: "image/jls"
        ),

        .jmp: FileType(
            type: .jmp,
            ext: "jmp",
            mime: "application/x-jmp-data"
        ),

        .lz4: FileType(
            type: .lz4,
            ext: "lz4",
            mime: "application/x-lz4"
        ),

        .macho: FileType(
            type: .macho,
            ext: "macho",
            mime: "application/x-mach-binary"
        ),

        .odg: FileType(
            type: .odg,
            ext: "odg",
            mime: "application/vnd.oasis.opendocument.graphics"
        ),

        .otg: FileType(
            type: .otg,
            ext: "otg",
            mime: "application/vnd.oasis.opendocument.graphics-template"
        ),

        .otp: FileType(
            type: .otp,
            ext: "otp",
            mime: "application/vnd.oasis.opendocument.presentation-template"
        ),

        .ots: FileType(
            type: .ots,
            ext: "ots",
            mime: "application/vnd.oasis.opendocument.spreadsheet-template"
        ),

        .ott: FileType(
            type: .ott,
            ext: "ott",
            mime: "application/vnd.oasis.opendocument.text-template"
        ),

        .parquet: FileType(
            type: .parquet,
            ext: "parquet",
            mime: "application/vnd.apache.parquet"
        ),

        .pcap: FileType(
            type: .pcap,
            ext: "pcap",
            mime: "application/vnd.tcpdump.pcap"
        ),

        .ppsm: FileType(
            type: .ppsm,
            ext: "ppsm",
            mime: "application/vnd.ms-powerpoint.slideshow.macroenabled.12"
        ),

        .ppsx: FileType(
            type: .ppsx,
            ext: "ppsx",
            mime: "application/vnd.openxmlformats-officedocument.presentationml.slideshow"
        ),

        .potm: FileType(
            type: .potm,
            ext: "potm",
            mime: "application/vnd.ms-powerpoint.template.macroenabled.12"
        ),

        .potx: FileType(
            type: .potx,
            ext: "potx",
            mime: "application/vnd.openxmlformats-officedocument.presentationml.template"
        ),

        .pst: FileType(
            type: .pst,
            ext: "pst",
            mime: "application/vnd.ms-outlook"
        ),

        .pptm: FileType(
            type: .pptm,
            ext: "pptm",
            mime: "application/vnd.ms-powerpoint.presentation.macroenabled.12"
        ),

        .reg: FileType(
            type: .reg,
            ext: "reg",
            mime: "application/x-ms-regedit"
        ),

        .rm: FileType(
            type: .rm,
            ext: "rm",
            mime: "application/vnd.rn-realmedia"
        ),

        .sav: FileType(
            type: .sav,
            ext: "sav",
            mime: "application/x-spss-sav"
        ),

        .ttc: FileType(
            type: .ttc,
            ext: "ttc",
            mime: "font/collection"
        ),

        .vsdx: FileType(
            type: .vsdx,
            ext: "vsdx",
            mime: "application/vnd.visio"
        ),

        .vtt: FileType(
            type: .vtt,
            ext: "vtt",
            mime: "text/vtt"
        ),

        .webp: FileType(
            type: .webp,
            ext: "webp",
            mime: "image/webp"
        ),

        .xlsm: FileType(
            type: .xlsm,
            ext: "xlsm",
            mime: "application/vnd.ms-excel.sheet.macroenabled.12"
        ),

        .xltm: FileType(
            type: .xltm,
            ext: "xltm",
            mime: "application/vnd.ms-excel.template.macroenabled.12"
        ),

        .xltx: FileType(
            type: .xltx,
            ext: "xltx",
            mime: "application/vnd.openxmlformats-officedocument.spreadsheetml.template"
        ),
    ]
}

extension FileType {
    private static let zipLikeTypes: Set<FileTypeMatchType> = [
        .apk,
        .docm,
        .docx,
        .dotm,
        .dotx,
        .epub,
        .jar,
        .odg,
        .odp,
        .ods,
        .odt,
        .otg,
        .otp,
        .ots,
        .ott,
        .ppsm,
        .ppsx,
        .potm,
        .potx,
        .pptm,
        .pptx,
        .threemf,
        .vsdx,
        .xlsm,
        .xlsx,
        .xltm,
        .xltx,
        .xpi,
        .zip,
    ]

    private static let maximumPrefixBytes = FileTypeMatch.all.reduce(into: 0) {
        currentMaximum, fileTypeMatch in
        currentMaximum = max(currentMaximum, fileTypeMatch.minimumPrefixBytes)
    }

    private static let fileTypesByExtension: [FileTypeExtension: [FileType]] = {
        Dictionary(grouping: FileType.all.values, by: \.type).mapValues(sortedFileTypes)
    }()

    private static let fileTypesByMIMEGroup: [FileTypeMIMEGroup: [FileType]] = {
        Dictionary(grouping: FileType.all.values, by: \.mimeGroup).mapValues(sortedFileTypes)
    }()

    private static let matchesByExtension: [FileTypeExtension: [FileTypeMatch]] = {
        var matches: [FileTypeExtension: [FileTypeMatch]] = [:]

        for fileTypeMatch in FileTypeMatch.all {
            guard let fileType = FileType.all[fileTypeMatch.type] else {
                continue
            }

            matches[fileType.type, default: []].append(fileTypeMatch)
        }

        return matches
    }()

    private static let matchesByMIMEGroup: [FileTypeMIMEGroup: [FileTypeMatch]] = {
        var matches: [FileTypeMIMEGroup: [FileTypeMatch]] = [:]

        for fileTypeMatch in FileTypeMatch.all {
            guard let fileType = FileType.all[fileTypeMatch.type] else {
                continue
            }

            matches[fileType.mimeGroup, default: []].append(fileTypeMatch)
        }

        return matches
    }()

    private static let minimumPrefixBytesByExtension: [FileTypeExtension: Int] = {
        FileType.matchesByExtension.mapValues { matches in
            minimumPrefixBytes(for: matches)
        }
    }()

    private static let dataRequirementByExtension: [FileTypeExtension: FileTypeDataRequirement] = {
        FileType.matchesByExtension.mapValues { matches in
            dataRequirement(for: matches)
        }
    }()

    private static let minimumPrefixBytesByMIMEGroup: [FileTypeMIMEGroup: Int] = {
        FileType.matchesByMIMEGroup.mapValues { matches in
            minimumPrefixBytes(for: matches)
        }
    }()

    private static let dataRequirementByMIMEGroup: [FileTypeMIMEGroup: FileTypeDataRequirement] = {
        FileType.matchesByMIMEGroup.mapValues { matches in
            dataRequirement(for: matches)
        }
    }()

    public static func minimumPrefixBytes(for type: FileTypeExtension) -> Int {
        minimumPrefixBytes(for: [type])
    }

    public static func minimumPrefixBytes(for types: [FileTypeExtension]) -> Int {
        types.reduce(into: 0) { currentMaximum, type in
            currentMaximum = max(currentMaximum, minimumPrefixBytesByExtension[type] ?? 0)
        }
    }

    public static func minimumPrefixBytes(for group: FileTypeMIMEGroup) -> Int {
        minimumPrefixBytes(for: [group])
    }

    public static func minimumPrefixBytes(for groups: [FileTypeMIMEGroup]) -> Int {
        groups.reduce(into: 0) { currentMaximum, group in
            currentMaximum = max(currentMaximum, minimumPrefixBytesByMIMEGroup[group] ?? 0)
        }
    }

    public static func dataRequirement(for type: FileTypeExtension) -> FileTypeDataRequirement {
        dataRequirement(for: [type])
    }

    public static func dataRequirement(for types: [FileTypeExtension]) -> FileTypeDataRequirement {
        if types.contains(where: { dataRequirementByExtension[$0] == .fullFile }) {
            return .fullFile
        }

        return .prefix(minimumPrefixBytes(for: types))
    }

    public static func dataRequirement(for group: FileTypeMIMEGroup) -> FileTypeDataRequirement {
        dataRequirement(for: [group])
    }

    public static func dataRequirement(for groups: [FileTypeMIMEGroup]) -> FileTypeDataRequirement {
        if groups.contains(where: { dataRequirementByMIMEGroup[$0] == .fullFile }) {
            return .fullFile
        }

        return .prefix(minimumPrefixBytes(for: groups))
    }

    public static func all(for type: FileTypeExtension) -> [FileType] {
        fileTypesByExtension[type] ?? []
    }

    public static func all(for group: FileTypeMIMEGroup) -> [FileType] {
        fileTypesByMIMEGroup[group] ?? []
    }

    public static func detect(in data: Data) -> FileType? {
        detect(in: data, matching: FileTypeMatch.all)
    }

    public static func detect(in data: Data, matching group: FileTypeMIMEGroup) -> FileType? {
        detect(in: data, matching: [group])
    }

    public static func detect(in data: Data, matching groups: [FileTypeMIMEGroup]) -> FileType? {
        detect(in: data, matching: fileTypeMatches(for: groups))
    }

    public static func detect(contentsOf url: URL) throws -> FileType? {
        let fileHandle = try FileHandle(forReadingFrom: url)
        defer {
            fileHandle.closeFile()
        }

        return try detect(using: fileHandle)
    }

    public static func detect(contentsOf url: URL, matching group: FileTypeMIMEGroup) throws
        -> FileType?
    {
        try detect(contentsOf: url, matching: [group])
    }

    public static func detect(contentsOf url: URL, matching groups: [FileTypeMIMEGroup]) throws
        -> FileType?
    {
        let fileHandle = try FileHandle(forReadingFrom: url)
        defer {
            fileHandle.closeFile()
        }

        return try detect(using: fileHandle, matching: groups)
    }

    public static func detect(using fileHandle: FileHandle) throws -> FileType? {
        try detect(using: fileHandle, matching: FileTypeMatch.all)
    }

    public static func detect(using fileHandle: FileHandle, matching group: FileTypeMIMEGroup)
        throws -> FileType?
    {
        try detect(using: fileHandle, matching: [group])
    }

    public static func detect(using fileHandle: FileHandle, matching groups: [FileTypeMIMEGroup])
        throws -> FileType?
    {
        try detect(using: fileHandle, matching: fileTypeMatches(for: groups))
    }
}

extension FileType {
    private static func detect(in data: Data, matching fileTypeMatches: [FileTypeMatch])
        -> FileType?
    {
        let requestedTypes = Set(fileTypeMatches.map(\.type))
        if !requestedTypes.isDisjoint(with: zipLikeTypes),
            let zipType = detectZipFileType(data),
            requestedTypes.contains(zipType)
        {
            return FileType.all[zipType]
        }

        for fileTypeMatch in fileTypeMatches {
            guard matchesPrefix(for: fileTypeMatch, in: data) else {
                continue
            }

            if matchesContents(for: fileTypeMatch, in: data) {
                return FileType.all[fileTypeMatch.type]
            }
        }

        return nil
    }

    private static func detect(
        using fileHandle: FileHandle, matching fileTypeMatches: [FileTypeMatch]
    )
        throws -> FileType?
    {
        fileHandle.seek(toFileOffset: 0)
        let prefixData = fileHandle.readData(ofLength: maximumPrefixBytes)

        var fullData: Data?
        let requestedTypes = Set(fileTypeMatches.map(\.type))

        if !requestedTypes.isDisjoint(with: zipLikeTypes), isZipArchive(prefixData) {
            let remainderData = fileHandle.readDataToEndOfFile()
            var combinedData = prefixData
            combinedData.append(remainderData)
            fullData = combinedData

            if let zipType = detectZipFileType(combinedData), requestedTypes.contains(zipType) {
                return FileType.all[zipType]
            }
        }

        for fileTypeMatch in fileTypeMatches {
            guard matchesPrefix(for: fileTypeMatch, in: prefixData) else {
                continue
            }

            let candidateData: Data
            if fileTypeMatch.requiresFullFile {
                if fullData == nil {
                    let remainderData = fileHandle.readDataToEndOfFile()
                    var combinedData = prefixData
                    combinedData.append(remainderData)
                    fullData = combinedData
                }

                candidateData = fullData ?? Data()
            } else {
                candidateData = prefixData
            }

            if matchesContents(for: fileTypeMatch, in: candidateData) {
                return FileType.all[fileTypeMatch.type]
            }
        }

        return nil
    }

    @available(*, deprecated, renamed: "minimumPrefixBytes(for:)")
    public static func getBytesCountFor(type: FileTypeExtension) -> Int {
        minimumPrefixBytes(for: type)
    }

    @available(*, deprecated, renamed: "minimumPrefixBytes(for:)")
    public static func getBytesCountFor(types: [FileTypeExtension]) -> Int {
        minimumPrefixBytes(for: types)
    }

    @available(*, deprecated, renamed: "all(for:)")
    public static func getFor(type: FileTypeExtension) -> [FileType] {
        all(for: type)
    }

    @available(*, deprecated, renamed: "detect(in:)")
    public static func getFor(data: Data) -> FileType? {
        detect(in: data)
    }
}

extension FileType {
    private static func sortedFileTypes(_ fileTypes: [FileType]) -> [FileType] {
        fileTypes.sorted { lhs, rhs in
            if lhs.ext != rhs.ext {
                return lhs.ext < rhs.ext
            }

            return lhs.mime.localizedStandardCompare(rhs.mime) == .orderedAscending
        }
    }

    private static func minimumPrefixBytes(for matches: [FileTypeMatch]) -> Int {
        matches.reduce(into: 0) { currentMaximum, fileTypeMatch in
            currentMaximum = max(currentMaximum, fileTypeMatch.minimumPrefixBytes)
        }
    }

    private static func dataRequirement(for matches: [FileTypeMatch]) -> FileTypeDataRequirement {
        if matches.contains(where: \.requiresFullFile) {
            return .fullFile
        }

        return .prefix(minimumPrefixBytes(for: matches))
    }

    private static func fileTypeMatches(for groups: [FileTypeMIMEGroup]) -> [FileTypeMatch] {
        guard groups.count != 1 || groups.first != nil else {
            return []
        }

        if let group = groups.first, groups.count == 1 {
            return matchesByMIMEGroup[group] ?? []
        }

        let allowedGroups = Set(groups)
        return FileTypeMatch.all.filter { fileTypeMatch in
            guard let fileType = FileType.all[fileTypeMatch.type] else {
                return false
            }

            return allowedGroups.contains(fileType.mimeGroup)
        }
    }

    fileprivate static func matchesPrefix(for fileTypeMatch: FileTypeMatch, in data: Data) -> Bool {
        if matchesPrefixDirect(for: fileTypeMatch, in: data) {
            return true
        }

        guard let strippedData = dataByStrippingID3Header(data), strippedData.count < data.count
        else {
            return false
        }

        return matchesPrefixDirect(for: fileTypeMatch, in: strippedData)
    }

    private static func matchesPrefixDirect(for fileTypeMatch: FileTypeMatch, in data: Data) -> Bool
    {
        guard fileTypeMatch.minimumPrefixBytes <= data.count else {
            return false
        }

        if let matchString = fileTypeMatch.matchString,
            !matchString.contains(where: { data.starts(with: $0.utf8) })
        {
            return false
        }

        if let matchBytes = fileTypeMatch.matchBytes,
            !matchBytes.contains(where: { data.starts(with: $0) })
        {
            return false
        }

        return true
    }

    fileprivate static func matchesContents(for fileTypeMatch: FileTypeMatch, in data: Data) -> Bool
    {
        if matchesContentsDirect(for: fileTypeMatch, in: data) {
            return true
        }

        guard let strippedData = dataByStrippingID3Header(data), strippedData.count < data.count
        else {
            return false
        }

        return matchesContentsDirect(for: fileTypeMatch, in: strippedData)
    }

    private static func matchesContentsDirect(for fileTypeMatch: FileTypeMatch, in data: Data)
        -> Bool
    {
        guard matchesPrefixDirect(for: fileTypeMatch, in: data) else {
            return false
        }

        guard let match = fileTypeMatch.match else {
            return fileTypeMatch.matchString != nil || fileTypeMatch.matchBytes != nil
        }

        return match(data)
    }
}
