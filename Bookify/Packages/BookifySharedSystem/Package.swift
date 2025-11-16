// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BookifySharedSystem",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "BookifySharedSystem",
            targets: ["BookifySharedSystem"]
        ),
    ],
    targets: [
        .target(
            name: "BookifySharedSystem",
            path: "Sources/BookifySharedSystem",
            sources: ["."]
        ),
        .testTarget(
            name: "BookifySharedSystemTests",
            dependencies: ["BookifySharedSystem"]
        ),
    ]
)
