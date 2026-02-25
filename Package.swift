// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SVGAPlayer",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "SVGAPlayer",
            targets: ["SVGAPlayer"]
        )
    ],
    dependencies: [
        // ZipArchive（SSZipArchive）
        .package(
            url: "https://github.com/ZipArchive/ZipArchive.git",
//            exact: "2.4.3" // 指定 2.4.3
            from: "2.0.0" // >= 2.0.0 且 < 3.0.0
        ),
    ],
    targets: [
        // Protobuf ObjC runtime
        .target(
            name: "Protobuf",
            path: "Protobuf",
            publicHeadersPath: ".",
            cSettings: [
                .unsafeFlags(["-fno-objc-arc"]), // 关闭 ARC
                .headerSearchPath("protobuf"),
            ]
        ),
        // 主库
        .target(
            name: "SVGAPlayer",
            dependencies: [
                "Protobuf",
                .product(
                    name: "ZipArchive",
                    package: "ZipArchive"
                ),
            ],
            path: "Source",
            publicHeadersPath: ".",
            linkerSettings: [
                .linkedFramework("AVFoundation"),
                .linkedLibrary("z")
            ]
        )
    ]
)
