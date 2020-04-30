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

 3gp, 3g2, 7z, aac, ac3, ai, aif, ali, amr, ape, apng, ar, arr, arw, asf, avi, ble, bmp, bpg, bz2, cab, cr2, cr3, crx, cur, dcm, deb, dmg, dng, docx, dsf, eot, epub, exe, f4a, f4b, f4p, f4v, flac, flif, flv, gif, glb, gz, heic, ico, ics, it, jp2, jpg, jpm, jpx, jxr, ktx, lnk, lz, m4a, m4b, m4p, m4v, mid, mie, mj2, mobi, mov, mp1, mp2, mp3, mp4, mpc, mpg, msi, mts, mxf, nef, nes, odp, ods, odt, oga, ogg, ogm, ogv, ogx, opus, orf, otf, pdf, png, pptx, ps, psd, qcp, raf, rar, rpm, rtf, rw2, s3m, shp, spx, sql, swf, tar, tif, ttf, voc, wasm, wav, wma, wmv, woff, woff2, wv, xlsx, xm, xml, xpi, xz, Z, zip



## Testing
```
swift test
```
