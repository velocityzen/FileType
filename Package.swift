// swift-tools-version:5.6
import PackageDescription

let package = Package(
  name: "FileType",
  products: [
    .library(
      name: "FileType",
      targets: ["FileType"]
    ),
  ],
  targets: [
    .target(
      name: "FileType"
    ),
    .testTarget(
      name: "FileTypeTests",
      dependencies: ["FileType"]
    ),
  ]
)
