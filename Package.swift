// swift-tools-version:5.2
import PackageDescription

let package = Package(
  name: "FileType",
  products: [
    .library(
      name: "FileType",
      targets: ["FileType"]),
  ],
  targets: [
    .target(
      name: "FileType",
      path: "./Sources"
    ),
    .testTarget(
      name: "FileTypeTests",
      dependencies: ["FileType"]),
  ]
)
