// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "FileType",
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
    ]
)
