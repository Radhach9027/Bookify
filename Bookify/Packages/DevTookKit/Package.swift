// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DevTookKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "DevTookKit",
            targets: ["DevTookKit"]
        ),
    ],
    targets: [
        .target(
            name: "DevTookKit"
        ),
    ]
)
