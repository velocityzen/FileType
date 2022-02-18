// swift-tools-version:5.3
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
