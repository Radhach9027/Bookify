// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BookifyLoggerSystem",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "BookifyLoggerSystem",
            targets: ["BookifyLoggerSystem"]
        ),
    ],
    targets: [
        .target(
            name: "BookifyLoggerSystem"
        ),
        .testTarget(
            name: "BookifyLoggerSystemTests",
            dependencies: ["BookifyLoggerSystem"]
        ),
    ]
)
