# FileType

The file type is detected by checking the magic number of the data.

This is swift port of [file-type](https://github.com/sindresorhus/file-type)

## Installation
### Swift Package Manager
```swift
import PackageDescription

let package = Package(
  name: "MyApp",
  dependencies: [
    .package(url: "https://github.com/velocityzen/FileType", from: "1.0.1")
  ]
)
```

## Usage

Inspect mime type

```swift
import FileType

let path = "/path/to/some-file.jpg"
let url = URL(fileURLWithPath: path, isDirectory: false)
let data = try! Data(contentsOf: url)
let fileType = FileType.getFor(data: data)

fileType?.type == .jpg // true
fileType! // FileType(type: .jpg, ext: "jpg", mime: "image/jpeg")

```

### .getFor(type: FileTypeExtension) -> [FileType]

returns all file types and mime information

### .getFor(data: Data) -> FileType?

returns file type detected by checking the magic number


### .getBytesCountFor(type: FileTypeExtension) -> Int

returns bytes count needed to detect file type

### .getBytesCountFor(types: [FileTypeExtension]) -> Int

returns max bytes count needed to detect file types


## Supported file types

- [`3g2`](https://en.wikipedia.org/wiki/3GP_and_3G2#3G2) - Multimedia container format defined by the 3GPP2 for 3G CDMA2000 multimedia services
- [`3gp`](https://en.wikipedia.org/wiki/3GP_and_3G2#3GP) - Multimedia container format defined by the Third Generation Partnership Project (3GPP) for 3G UMTS multimedia services
- [`7z`](https://en.wikipedia.org/wiki/7z)
- [`aac`](https://en.wikipedia.org/wiki/Advanced_Audio_Coding) - Advanced Audio Coding
- [`ac3`](https://www.atsc.org/standard/a522012-digital-audio-compression-ac-3-e-ac-3-standard-12172012/) - ATSC A/52 Audio File
- [`ai`](https://en.wikipedia.org/wiki/Adobe_Illustrator_Artwork) - Adobe Illustrator Artwork
- [`aif`](https://en.wikipedia.org/wiki/Audio_Interchange_File_Format)
- [`alias`](https://en.wikipedia.org/wiki/Alias_%28Mac_OS%29) - macOS Alias file
- [`amr`](https://en.wikipedia.org/wiki/Adaptive_Multi-Rate_audio_codec)
- [`ape`](https://en.wikipedia.org/wiki/Monkey%27s_Audio) - Monkey's Audio
- [`apng`](https://en.wikipedia.org/wiki/APNG) - Animated Portable Network Graphics
- [`ar`](https://en.wikipedia.org/wiki/Ar_(Unix))
- [`arrow`](https://arrow.apache.org) - Columnar format for tables of data
- [`arw`](https://en.wikipedia.org/wiki/Raw_image_format#ARW) - Sony Alpha Raw image file
- [`asf`](https://en.wikipedia.org/wiki/Advanced_Systems_Format) - Advanced Systems Format
- [`avi`](https://en.wikipedia.org/wiki/Audio_Video_Interleave)
- [`avif`](https://en.wikipedia.org/wiki/AV1#AV1_Image_File_Format_(AVIF)) - AV1 Image File Format
- [`blend`](https://wiki.blender.org/index.php/Dev:Source/Architecture/File_Format)
- [`bmp`](https://en.wikipedia.org/wiki/BMP_file_format)
- [`bpg`](https://bellard.org/bpg/)
- [`bz2`](https://en.wikipedia.org/wiki/Bzip2)
- [`cab`](https://en.wikipedia.org/wiki/Cabinet_(file_format))
- [`cr2`](https://fileinfo.com/extension/cr2) - Canon Raw image file (v2)
- [`cr3`](https://fileinfo.com/extension/cr3) - Canon Raw image file (v3)
- [`crx`](https://developer.chrome.com/extensions/crx)
- [`cur`](https://en.wikipedia.org/wiki/ICO_(file_format))
- [`dcm`](https://en.wikipedia.org/wiki/DICOM#Data_format) - DICOM Image File
- [`deb`](https://en.wikipedia.org/wiki/Deb_(file_format))
- [`dmg`](https://en.wikipedia.org/wiki/Apple_Disk_Image)
- [`dng`](https://en.wikipedia.org/wiki/Digital_Negative) - Adobe Digital Negative image file
- [`docx`](https://en.wikipedia.org/wiki/Office_Open_XML)
- [`dsf`](https://dsd-guide.com/sites/default/files/white-papers/DSFFileFormatSpec_E.pdf) - Sony DSD Stream File (DSF)
- [`eot`](https://en.wikipedia.org/wiki/Embedded_OpenType)
- [`eps`](https://en.wikipedia.org/wiki/Encapsulated_PostScript) - Encapsulated PostScript
- [`epub`](https://en.wikipedia.org/wiki/EPUB)
- [`exe`](https://en.wikipedia.org/wiki/.exe)
- [`f4a`](https://en.wikipedia.org/wiki/Flash_Video) - Audio-only ISO base media file format used by Adobe Flash Player
- [`f4b`](https://en.wikipedia.org/wiki/Flash_Video) - Audiobook and podcast ISO base media file format used by Adobe Flash Player
- [`f4p`](https://en.wikipedia.org/wiki/Flash_Video) - ISO base media file format protected by Adobe Access DRM used by Adobe Flash Player
- [`f4v`](https://en.wikipedia.org/wiki/Flash_Video) - ISO base media file format used by Adobe Flash Player
- [`flac`](https://en.wikipedia.org/wiki/FLAC)
- [`flif`](https://en.wikipedia.org/wiki/Free_Lossless_Image_Format)
- [`flv`](https://en.wikipedia.org/wiki/Flash_Video)
- [`gif`](https://en.wikipedia.org/wiki/GIF)
- [`glb`](https://github.com/KhronosGroup/glTF) - GL Transmission Format
- [`gz`](https://en.wikipedia.org/wiki/Gzip)
- [`heic`](https://nokiatech.github.io/heif/technical.html)
- [`icns`](https://en.wikipedia.org/wiki/Apple_Icon_Image_format)
- [`ico`](https://en.wikipedia.org/wiki/ICO_(file_format))
- [`ics`](https://en.wikipedia.org/wiki/ICalendar#Data_format) - iCalendar
- [`indd`](https://en.wikipedia.org/wiki/Adobe_InDesign#File_format)
- [`it`](https://wiki.openmpt.org/Manual:_Module_formats#The_Impulse_Tracker_format_.28.it.29) - Audio module format: Impulse Tracker
- [`jp2`](https://en.wikipedia.org/wiki/JPEG_2000) - JPEG 2000
- [`jpg`](https://en.wikipedia.org/wiki/JPEG)
- [`jpm`](https://en.wikipedia.org/wiki/JPEG_2000) - JPEG 2000
- [`jpx`](https://en.wikipedia.org/wiki/JPEG_2000) - JPEG 2000
- [`jxr`](https://en.wikipedia.org/wiki/JPEG_XR)
- [`ktx`](https://www.khronos.org/opengles/sdk/tools/KTX/file_format_spec/)
- [`lnk`](https://en.wikipedia.org/wiki/Shortcut_%28computing%29#Microsoft_Windows) - Microsoft Windows file shortcut
- [`lz`](https://en.wikipedia.org/wiki/Lzip)
- [`lzh`](https://en.wikipedia.org/wiki/LHA_(file_format)) - LZH archive
- [`m4a`](https://en.wikipedia.org/wiki/M4A) - Audio-only MPEG-4 files
- [`m4b`](https://en.wikipedia.org/wiki/M4B) - Audiobook and podcast MPEG-4 files, which also contain metadata including chapter markers, images, and hyperlinks
- [`m4p`](https://en.wikipedia.org/wiki/MPEG-4_Part_14#Filename_extensions) - MPEG-4 files with audio streams encrypted by FairPlay Digital Rights Management as were sold through the iTunes Store
- [`m4v`](https://en.wikipedia.org/wiki/M4V) -  MPEG-4 Visual bitstreams
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
- [`msi`](https://en.wikipedia.org/wiki/Windows_Installer)
- [`mts`](https://en.wikipedia.org/wiki/.m2ts)
- [`mxf`](https://en.wikipedia.org/wiki/Material_Exchange_Format)
- [`nef`](https://www.nikonusa.com/en/learn-and-explore/a/products-and-innovation/nikon-electronic-format-nef.html) - Nikon Electronic Format image file
- [`nes`](https://fileinfo.com/extension/nes)
- [`odp`](https://en.wikipedia.org/wiki/OpenDocument) - OpenDocument for presentations
- [`ods`](https://en.wikipedia.org/wiki/OpenDocument) - OpenDocument for spreadsheets
- [`odt`](https://en.wikipedia.org/wiki/OpenDocument) - OpenDocument for word processing
- [`oga`](https://en.wikipedia.org/wiki/Ogg)
- [`ogg`](https://en.wikipedia.org/wiki/Ogg)
- [`ogm`](https://en.wikipedia.org/wiki/Ogg)
- [`ogv`](https://en.wikipedia.org/wiki/Ogg)
- [`ogx`](https://en.wikipedia.org/wiki/Ogg)
- [`opus`](https://en.wikipedia.org/wiki/Opus_(audio_format))
- [`orf`](https://en.wikipedia.org/wiki/ORF_format) - Olympus Raw image file
- [`otf`](https://en.wikipedia.org/wiki/OpenType)
- [`pcap`](https://wiki.wireshark.org/Development/LibpcapFileFormat) - Libpcap File Format
- [`pdf`](https://en.wikipedia.org/wiki/Portable_Document_Format)
- [`pgp`](https://en.wikipedia.org/wiki/Pretty_Good_Privacy) - Pretty Good Privacy
- [`png`](https://en.wikipedia.org/wiki/Portable_Network_Graphics)
- [`pptx`](https://en.wikipedia.org/wiki/Office_Open_XML)
- [`ps`](https://en.wikipedia.org/wiki/Postscript)
- [`psd`](https://en.wikipedia.org/wiki/Adobe_Photoshop#File_format)
- [`qcp`](https://en.wikipedia.org/wiki/QCP)
- [`raf`](https://en.wikipedia.org/wiki/Raw_image_format) - Fujifilm RAW image file
- [`rar`](https://en.wikipedia.org/wiki/RAR_(file_format))
- [`rpm`](https://fileinfo.com/extension/rpm)
- [`rtf`](https://en.wikipedia.org/wiki/Rich_Text_Format)
- [`rw2`](https://en.wikipedia.org/wiki/Raw_image_format) - Panasonic RAW image file
- [`s3m`](https://wiki.openmpt.org/Manual:_Module_formats#The_ScreamTracker_3_format_.28.s3m.29) - Audio module format: ScreamTracker 3
- [`shp`](https://en.wikipedia.org/wiki/Shapefile) - Geospatial vector data format
- [`skp`](https://en.wikipedia.org/wiki/SketchUp) - SketchUp
- [`spx`](https://en.wikipedia.org/wiki/Ogg)
- [`sqlite`](https://www.sqlite.org/fileformat2.html)
- [`swf`](https://en.wikipedia.org/wiki/SWF)
- [`tar`](https://en.wikipedia.org/wiki/Tar_(computing)#File_format)
- [`tif`](https://en.wikipedia.org/wiki/Tagged_Image_File_Format)
- [`ttf`](https://en.wikipedia.org/wiki/TrueType)
- [`voc`](https://wiki.multimedia.cx/index.php/Creative_Voice) - Creative Voice File
- [`wasm`](https://en.wikipedia.org/wiki/WebAssembly)
- [`wav`](https://en.wikipedia.org/wiki/WAV)
- [`webm`](https://en.wikipedia.org/wiki/WebM)
- [`webp`](https://en.wikipedia.org/wiki/WebP)
- [`wma`](https://en.wikipedia.org/wiki/Windows_Media_Audio) - Windows Media Audio
- [`wmv`](https://en.wikipedia.org/wiki/Windows_Media_Video) - Windows Media Video
- [`woff2`](https://en.wikipedia.org/wiki/Web_Open_Font_Format)
- [`woff`](https://en.wikipedia.org/wiki/Web_Open_Font_Format)
- [`wv`](https://en.wikipedia.org/wiki/WavPack) - WavPack
- [`xlsx`](https://en.wikipedia.org/wiki/Office_Open_XML)
- [`xm`](https://wiki.openmpt.org/Manual:_Module_formats#The_FastTracker_2_format_.28.xm.29) - Audio module format: FastTracker 2
- [`xml`](https://en.wikipedia.org/wiki/XML)
- [`xpi`](https://en.wikipedia.org/wiki/XPInstall)
- [`xz`](https://en.wikipedia.org/wiki/Xz)
- [`Z`](https://fileinfo.com/extension/z)
- [`zip`](https://en.wikipedia.org/wiki/Zip_(file_format))

*Pull requests are welcome for additional commonly used file types.*


## Testing
```
swift test
```
