// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BookifyTelemetryKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "BookifyTelemetryKit",
            targets: ["BookifyTelemetryKit"]
        ),
    ],
    targets: [
        .target(
            name: "BookifyTelemetryKit"
        ),
        .testTarget(
            name: "BookifyTelemetryKitTests",
            dependencies: ["BookifyTelemetryKit"]
        ),
    ]
)
