// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BookifyDesignSystem",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "BookifyDesignSystem",
            targets: ["BookifyDesignSystem"]
        ),
    ],
    targets: [
        .target(
            name: "BookifyDesignSystem"
        ),
        .testTarget(
            name: "BookifyDesignSystemTests",
            dependencies: ["BookifyDesignSystem"]
        ),
    ]
)

