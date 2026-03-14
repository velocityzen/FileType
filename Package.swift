// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "FileType",
    platforms: [
        .macOS(.v11),
        .iOS(.v14),
        .tvOS(.v14),
        .watchOS(.v7),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "FileType",
            targets: ["FileType"]
        )
    ],
    targets: [
        .systemLibrary(
            name: "CZlib",
            providers: [
                .apt(["zlib1g-dev"]),
                .brew(["zlib"]),
            ]
        ),
        .target(
            name: "FileType",
            dependencies: ["CZlib"]
        ),
        .testTarget(
            name: "FileTypeTests",
            dependencies: ["FileType"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
