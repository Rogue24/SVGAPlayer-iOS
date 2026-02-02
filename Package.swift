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
        // Protobuf（pbobjc runtime 在这里）
        .package(
            url: "https://github.com/apple/swift-protobuf.git",
            exact: "1.29.0" // 对应 Protobuf 3.29.x
        ),

        // SSZipArchive
        .package(
            url: "https://github.com/ZipArchive/ZipArchive.git",
            from: "2.6.0"
        )
    ],
    targets: [
        .target(
            name: "SVGAPlayer",
            path: "Source",
            publicHeadersPath: ".",
            cSettings: [
                // 等价 podspec 里的：
                // GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS=1
                .define("GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS", to: "1"),

                // pbobjc 头文件搜索
                .headerSearchPath("pbobjc")
            ],
            linkerSettings: [
                .linkedFramework("AVFoundation"),
                .linkedLibrary("z")
            ],
            dependencies: [
                .product(name: "SSZipArchive", package: "ZipArchive"),
                .product(name: "SwiftProtobuf", package: "swift-protobuf")
            ]
        )
    ]
)
