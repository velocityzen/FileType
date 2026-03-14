# FileType

The file type is detected by checking signature bytes and, for some container formats, scanning the full file contents when required.

This is swift port of [file-type](https://github.com/sindresorhus/file-type)

## Installation

## Requirements

- Swift 6.2+
- Xcode 26.3+ or another Swift 6.2-compatible toolchain

### Swift Package Manager

```swift
import PackageDescription

let package = Package(
  name: "MyApp",
  dependencies: [
    .package(url: "https://github.com/velocityzen/FileType", branch: "main")
  ]
)
```

If you are consuming a tagged release instead of `main`, use the latest Swift 6.2-compatible tag.

## Usage

Inspect mime type

```swift
import FileType

let path = "/path/to/some-file.jpg"
let url = URL(fileURLWithPath: path, isDirectory: false)
let fileType = try FileType.detect(contentsOf: url)

fileType?.type == .jpg // true
fileType // FileType(type: .jpg, ext: "jpg", mime: "image/jpeg")
```

Limit detection to MIME major groups when you already know the broad file family:

```swift
import FileType

let data = try Data(contentsOf: url)
let imageType = FileType.detect(in: data, matching: .image)

imageType?.mimeGroup == .image // true
```

Inspect the detection requirement before sampling file contents:

```swift
import FileType

switch FileType.dataRequirement(for: .docx) {
case let .prefix(byteCount):
  // Read only the prefix for simple signatures.
  print(byteCount)
case .fullFile:
  // Container formats like DOCX require the full file.
  print("Read the full file")
}

```

### `FileType.all(for: FileTypeExtension) -> [FileType]`

returns all file types and mime information

### `FileType.all(for: FileTypeMIMEGroup) -> [FileType]`

returns all file types whose mime begins with that major type

### `FileType.detect(in: Data) -> FileType?`

returns file type detected by checking the magic number

### `FileType.detect(in: Data, matching: FileTypeMIMEGroup) -> FileType?`

limits detection to a MIME major group such as `.image`, `.audio`, or `.video`

### `FileType.detect(contentsOf: URL) throws -> FileType?`

detects the type from a file URL and only loads the full file when a detector requires it

### `FileType.detect(contentsOf: URL, matching: FileTypeMIMEGroup) throws -> FileType?`

limits URL-based detection to one MIME major group

### `FileType.detect(using: FileHandle) throws -> FileType?`

detects the type from a file handle positioned at the start of the file

### `FileType.detect(using: FileHandle, matching: FileTypeMIMEGroup) throws -> FileType?`

limits file-handle detection to one MIME major group

### `FileType.minimumPrefixBytes(for: FileTypeExtension) -> Int`

returns the minimum prefix size used by the detector for that type

### `FileType.minimumPrefixBytes(for: FileTypeMIMEGroup) -> Int`

returns the minimum prefix size needed for that MIME major group

### `FileType.dataRequirement(for: FileTypeExtension) -> FileTypeDataRequirement`

returns whether the detector can work from a prefix or requires the full file

### `FileType.dataRequirement(for: FileTypeMIMEGroup) -> FileTypeDataRequirement`

returns whether that MIME major group can work from a prefix or requires the full file

### `FileTypeExtension.canonicalFileExtension -> String`

returns the canonical on-disk extension for a public file type case

### `FileType.mimeGroup -> FileTypeMIMEGroup`

returns the first component of the detected MIME type

### Deprecated compatibility APIs

`getFor(...)` and `getBytesCountFor(...)` remain as deprecated wrappers for older callers.

## Supported file types

- [`3g2`](https://en.wikipedia.org/wiki/3GP_and_3G2#3G2) - Multimedia container format defined by the 3GPP2 for 3G CDMA2000 multimedia services
- [`3gp`](https://en.wikipedia.org/wiki/3GP_and_3G2#3GP) - Multimedia container format defined by the Third Generation Partnership Project (3GPP) for 3G UMTS multimedia services
- [`3mf`](https://en.wikipedia.org/wiki/3D_Manufacturing_Format) - 3D Manufacturing Format
- [`7z`](https://en.wikipedia.org/wiki/7z)
- [`aac`](https://en.wikipedia.org/wiki/Advanced_Audio_Coding) - Advanced Audio Coding
- [`ac3`](https://www.atsc.org/standard/a522012-digital-audio-compression-ac-3-e-ac-3-standard-12172012/) - ATSC A/52 Audio File
- [`ace`](https://en.wikipedia.org/wiki/ACE_(compressed_file_format))
- [`ai`](https://en.wikipedia.org/wiki/Adobe_Illustrator_Artwork) - Adobe Illustrator Artwork
- [`aif`](https://en.wikipedia.org/wiki/Audio_Interchange_File_Format)
- [`alias`](https://en.wikipedia.org/wiki/Alias_%28Mac_OS%29) - macOS Alias file
- [`amr`](https://en.wikipedia.org/wiki/Adaptive_Multi-Rate_audio_codec)
- [`ape`](https://en.wikipedia.org/wiki/Monkey%27s_Audio) - Monkey's Audio
- [`apk`](https://en.wikipedia.org/wiki/Apk_(file_format))
- [`apng`](https://en.wikipedia.org/wiki/APNG) - Animated Portable Network Graphics
- [`ar`](<https://en.wikipedia.org/wiki/Ar_(Unix)>)
- [`arj`](https://en.wikipedia.org/wiki/ARJ)
- [`arrow`](https://arrow.apache.org) - Columnar format for tables of data
- [`arw`](https://en.wikipedia.org/wiki/Raw_image_format#ARW) - Sony Alpha Raw image file
- [`asar`](https://github.com/electron/asar) - Simple extensive tar-like archive format with indexing
- [`asf`](https://en.wikipedia.org/wiki/Advanced_Systems_Format) - Advanced Systems Format
- [`avi`](https://en.wikipedia.org/wiki/Audio_Video_Interleave)
- [`avif`](<https://en.wikipedia.org/wiki/AV1#AV1_Image_File_Format_(AVIF)>) - AV1 Image File Format
- [`avro`](https://avro.apache.org)
- [`blend`](https://wiki.blender.org/index.php/Dev:Source/Architecture/File_Format)
- [`bmp`](https://en.wikipedia.org/wiki/BMP_file_format)
- [`bpg`](https://bellard.org/bpg/)
- [`bz2`](https://en.wikipedia.org/wiki/Bzip2)
- [`cab`](<https://en.wikipedia.org/wiki/Cabinet_(file_format)>)
- [`cfb`](https://en.wikipedia.org/wiki/Compound_File_Binary_Format)
- [`chm`](https://en.wikipedia.org/wiki/Microsoft_Compiled_HTML_Help) - Microsoft Compiled HTML Help
- [`cpio`](https://en.wikipedia.org/wiki/Cpio)
- [`cr2`](https://fileinfo.com/extension/cr2) - Canon Raw image file (v2)
- [`cr3`](https://fileinfo.com/extension/cr3) - Canon Raw image file (v3)
- [`crx`](https://developer.chrome.com/extensions/crx)
- [`cur`](<https://en.wikipedia.org/wiki/ICO_(file_format)>)
- [`dat`](https://en.wikipedia.org/wiki/Windows_Registry) - Windows Registry hive
- [`dcm`](https://en.wikipedia.org/wiki/DICOM#Data_format) - DICOM Image File
- [`deb`](<https://en.wikipedia.org/wiki/Deb_(file_format)>)
- [`dmg`](https://en.wikipedia.org/wiki/Apple_Disk_Image)
- [`dng`](https://en.wikipedia.org/wiki/Digital_Negative) - Adobe Digital Negative image file
- [`docm`](https://en.wikipedia.org/wiki/Office_Open_XML)
- [`docx`](https://en.wikipedia.org/wiki/Office_Open_XML)
- [`dotm`](https://en.wikipedia.org/wiki/Office_Open_XML)
- [`dotx`](https://en.wikipedia.org/wiki/Office_Open_XML)
- [`drc`](https://google.github.io/draco/)
- [`dwg`](https://en.wikipedia.org/wiki/.dwg)
- [`dsf`](https://dsd-guide.com/sites/default/files/white-papers/DSFFileFormatSpec_E.pdf) - Sony DSD Stream File (DSF)
- [`elf`](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format) - Unix Executable and Linkable Format
- [`eot`](https://en.wikipedia.org/wiki/Embedded_OpenType)
- [`eps`](https://en.wikipedia.org/wiki/Encapsulated_PostScript) - Encapsulated PostScript
- [`epub`](https://en.wikipedia.org/wiki/EPUB)
- [`exe`](https://en.wikipedia.org/wiki/.exe)
- [`f4a`](https://en.wikipedia.org/wiki/Flash_Video) - Audio-only ISO base media file format used by Adobe Flash Player
- [`f4b`](https://en.wikipedia.org/wiki/Flash_Video) - Audiobook and podcast ISO base media file format used by Adobe Flash Player
- [`f4p`](https://en.wikipedia.org/wiki/Flash_Video) - ISO base media file format protected by Adobe Access DRM used by Adobe Flash Player
- [`f4v`](https://en.wikipedia.org/wiki/Flash_Video) - ISO base media file format used by Adobe Flash Player
- [`fbx`](https://en.wikipedia.org/wiki/FBX)
- [`flac`](https://en.wikipedia.org/wiki/FLAC)
- [`flif`](https://en.wikipedia.org/wiki/Free_Lossless_Image_Format)
- [`flv`](https://en.wikipedia.org/wiki/Flash_Video)
- [`gif`](https://en.wikipedia.org/wiki/GIF)
- [`glb`](https://github.com/KhronosGroup/glTF) - GL Transmission Format
- [`gz`](https://en.wikipedia.org/wiki/Gzip)
- [`heic`](https://nokiatech.github.io/heif/technical.html)
- [`icc`](https://en.wikipedia.org/wiki/ICC_profile)
- [`icns`](https://en.wikipedia.org/wiki/Apple_Icon_Image_format)
- [`ico`](<https://en.wikipedia.org/wiki/ICO_(file_format)>)
- [`ics`](https://en.wikipedia.org/wiki/ICalendar#Data_format) - iCalendar
- [`indd`](https://en.wikipedia.org/wiki/Adobe_InDesign#File_format)
- [`it`](https://wiki.openmpt.org/Manual:_Module_formats#The_Impulse_Tracker_format_.28.it.29) - Audio module format: Impulse Tracker
- [`j2c`](https://en.wikipedia.org/wiki/JPEG_2000) - JPEG 2000 codestream
- [`jar`](https://en.wikipedia.org/wiki/JAR_(file_format))
- [`jp2`](https://en.wikipedia.org/wiki/JPEG_2000) - JPEG 2000
- [`jpg`](https://en.wikipedia.org/wiki/JPEG)
- [`jls`](https://en.wikipedia.org/wiki/JPEG-LS)
- [`jmp`](https://www.jmp.com) - JMP data file
- [`jpm`](https://en.wikipedia.org/wiki/JPEG_2000) - JPEG 2000
- [`jpx`](https://en.wikipedia.org/wiki/JPEG_2000) - JPEG 2000
- [`jxl`](https://en.wikipedia.org/wiki/JPEG_XL) - JPEG XL image format
- [`jxr`](https://en.wikipedia.org/wiki/JPEG_XR)
- [`ktx`](https://www.khronos.org/opengles/sdk/tools/KTX/file_format_spec/)
- [`lnk`](https://en.wikipedia.org/wiki/Shortcut_%28computing%29#Microsoft_Windows) - Microsoft Windows file shortcut
- [`lz`](https://en.wikipedia.org/wiki/Lzip)
- [`lz4`](https://en.wikipedia.org/wiki/LZ4_(compression_algorithm))
- [`lzh`](<https://en.wikipedia.org/wiki/LHA_(file_format)>) - LZH archive
- [`m4a`](https://en.wikipedia.org/wiki/M4A) - Audio-only MPEG-4 files
- [`m4b`](https://en.wikipedia.org/wiki/M4B) - Audiobook and podcast MPEG-4 files, which also contain metadata including chapter markers, images, and hyperlinks
- [`m4p`](https://en.wikipedia.org/wiki/MPEG-4_Part_14#Filename_extensions) - MPEG-4 files with audio streams encrypted by FairPlay Digital Rights Management as were sold through the iTunes Store
- [`m4v`](https://en.wikipedia.org/wiki/M4V) - MPEG-4 Visual bitstreams
- [`macho`](https://en.wikipedia.org/wiki/Mach-O)
- [`mid`](https://en.wikipedia.org/wiki/MIDI)
- [`mie`](https://en.wikipedia.org/wiki/Sidecar_file) - Dedicated meta information format which supports storage of binary as well as textual meta information
- [`mj2`](https://en.wikipedia.org/wiki/Motion_JPEG_2000) - Motion JPEG 2000
- [`mkv`](https://en.wikipedia.org/wiki/Matroska)
- [`mobi`](https://en.wikipedia.org/wiki/Mobipocket) - Mobipocket
- [`mov`](https://en.wikipedia.org/wiki/QuickTime_File_Format)
- [`mp1`](https://en.wikipedia.org/wiki/MPEG-1_Audio_Layer_I) - MPEG-1 Audio Layer I
- [`mp2`](https://en.wikipedia.org/wiki/MPEG-1_Audio_Layer_II)
- [`mp3`](https://en.wikipedia.org/wiki/MP3)
- [`mp4`](https://en.wikipedia.org/wiki/MPEG-4_Part_14#Filename_extensions)
- [`mpc`](https://en.wikipedia.org/wiki/Musepack) - Musepack (SV7 & SV8)
- [`mpg`](https://en.wikipedia.org/wiki/MPEG-1)
- [`mts`](https://en.wikipedia.org/wiki/.m2ts) - MPEG-2 Transport Stream, both raw and Blu-ray Disc Audio-Video (BDAV) versions
- [`mxf`](https://en.wikipedia.org/wiki/Material_Exchange_Format)
- [`nef`](https://www.nikonusa.com/en/learn-and-explore/a/products-and-innovation/nikon-electronic-format-nef.html) - Nikon Electronic Format image file
- [`nes`](https://fileinfo.com/extension/nes)
- [`odg`](https://en.wikipedia.org/wiki/OpenDocument) - OpenDocument graphics
- [`odp`](https://en.wikipedia.org/wiki/OpenDocument) - OpenDocument for presentations
- [`ods`](https://en.wikipedia.org/wiki/OpenDocument) - OpenDocument for spreadsheets
- [`odt`](https://en.wikipedia.org/wiki/OpenDocument) - OpenDocument for word processing
- [`oga`](https://en.wikipedia.org/wiki/Ogg)
- [`ogg`](https://en.wikipedia.org/wiki/Ogg)
- [`ogm`](https://en.wikipedia.org/wiki/Ogg)
- [`ogv`](https://en.wikipedia.org/wiki/Ogg)
- [`ogx`](https://en.wikipedia.org/wiki/Ogg)
- [`opus`](<https://en.wikipedia.org/wiki/Opus_(audio_format)>)
- [`orf`](https://en.wikipedia.org/wiki/ORF_format) - Olympus Raw image file
- [`otf`](https://en.wikipedia.org/wiki/OpenType)
- [`otg`](https://en.wikipedia.org/wiki/OpenDocument) - OpenDocument graphics template
- [`otp`](https://en.wikipedia.org/wiki/OpenDocument) - OpenDocument presentation template
- [`ots`](https://en.wikipedia.org/wiki/OpenDocument) - OpenDocument spreadsheet template
- [`ott`](https://en.wikipedia.org/wiki/OpenDocument) - OpenDocument text template
- [`parquet`](https://parquet.apache.org)
- [`pcap`](https://wiki.wireshark.org/Development/LibpcapFileFormat) - Libpcap File Format
- [`pdf`](https://en.wikipedia.org/wiki/Portable_Document_Format)
- [`pgp`](https://en.wikipedia.org/wiki/Pretty_Good_Privacy) - Pretty Good Privacy
- [`png`](https://en.wikipedia.org/wiki/Portable_Network_Graphics)
- [`ppsm`](https://en.wikipedia.org/wiki/Office_Open_XML)
- [`ppsx`](https://en.wikipedia.org/wiki/Office_Open_XML)
- [`potm`](https://en.wikipedia.org/wiki/Office_Open_XML)
- [`potx`](https://en.wikipedia.org/wiki/Office_Open_XML)
- [`pptm`](https://en.wikipedia.org/wiki/Office_Open_XML)
- [`pptx`](https://en.wikipedia.org/wiki/Office_Open_XML)
- [`ps`](https://en.wikipedia.org/wiki/Postscript)
- [`psd`](https://en.wikipedia.org/wiki/Adobe_Photoshop#File_format)
- [`pst`](https://en.wikipedia.org/wiki/Personal_Storage_Table)
- [`qcp`](https://en.wikipedia.org/wiki/QCP)
- [`raf`](https://en.wikipedia.org/wiki/Raw_image_format) - Fujifilm RAW image file
- [`rar`](<https://en.wikipedia.org/wiki/RAR_(file_format)>)
- [`reg`](https://en.wikipedia.org/wiki/Windows_Registry) - Windows Registry export
- [`rm`](https://en.wikipedia.org/wiki/RealMedia)
- [`rpm`](https://fileinfo.com/extension/rpm)
- [`rtf`](https://en.wikipedia.org/wiki/Rich_Text_Format)
- [`rw2`](https://en.wikipedia.org/wiki/Raw_image_format) - Panasonic RAW image file
- [`s3m`](https://wiki.openmpt.org/Manual:_Module_formats#The_ScreamTracker_3_format_.28.s3m.29) - Audio module format: ScreamTracker 3
- [`sav`](https://en.wikipedia.org/wiki/IBM_SPSS_Statistics) - SPSS data file
- [`shp`](https://en.wikipedia.org/wiki/Shapefile) - Geospatial vector data format
- [`skp`](https://en.wikipedia.org/wiki/SketchUp) - SketchUp
- [`spx`](https://en.wikipedia.org/wiki/Ogg)
- [`sqlite`](https://www.sqlite.org/fileformat2.html)
- [`stl`](<https://en.wikipedia.org/wiki/STL_(file_format)>) - Standard Tesselated Geometry File Format (ASCII only)
- [`swf`](https://en.wikipedia.org/wiki/SWF)
- [`tar`](<https://en.wikipedia.org/wiki/Tar_(computing)#File_format>)
- [`tif`](https://en.wikipedia.org/wiki/Tagged_Image_File_Format)
- [`ttc`](https://en.wikipedia.org/wiki/TrueType#TrueType_Collection) - TrueType Collection
- [`ttf`](https://en.wikipedia.org/wiki/TrueType)
- [`vcf`](https://en.wikipedia.org/wiki/VCard) - vCard
- [`voc`](https://wiki.multimedia.cx/index.php/Creative_Voice) - Creative Voice File
- [`vsdx`](https://en.wikipedia.org/wiki/Microsoft_Visio#File_formats)
- [`vtt`](https://en.wikipedia.org/wiki/WebVTT)
- [`wasm`](https://en.wikipedia.org/wiki/WebAssembly)
- [`wav`](https://en.wikipedia.org/wiki/WAV)
- [`webm`](https://en.wikipedia.org/wiki/WebM)
- [`webp`](https://en.wikipedia.org/wiki/WebP)
- [`woff2`](https://en.wikipedia.org/wiki/Web_Open_Font_Format)
- [`woff`](https://en.wikipedia.org/wiki/Web_Open_Font_Format)
- [`wv`](https://en.wikipedia.org/wiki/WavPack) - WavPack
- [`xcf`](<https://en.wikipedia.org/wiki/XCF_(file_format)>) - eXperimental Computing Facility
- [`xlsm`](https://en.wikipedia.org/wiki/Office_Open_XML)
- [`xlsx`](https://en.wikipedia.org/wiki/Office_Open_XML)
- [`xltm`](https://en.wikipedia.org/wiki/Office_Open_XML)
- [`xltx`](https://en.wikipedia.org/wiki/Office_Open_XML)
- [`xm`](https://wiki.openmpt.org/Manual:_Module_formats#The_FastTracker_2_format_.28.xm.29) - Audio module format: FastTracker 2
- [`xml`](https://en.wikipedia.org/wiki/XML)
- [`xpi`](https://en.wikipedia.org/wiki/XPInstall)
- [`xz`](https://en.wikipedia.org/wiki/Xz)
- [`Z`](https://fileinfo.com/extension/z)
- [`zip`](<https://en.wikipedia.org/wiki/Zip_(file_format)>)
- [`zst`](https://en.wikipedia.org/wiki/Zstandard) - Archive file

_Pull requests are welcome for additional commonly used file types._

## Testing

```
swift test
```
