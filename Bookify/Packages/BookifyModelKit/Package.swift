// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
let package = Package(
    name: "BookifyModelKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "BookifyModelKit", targets: ["BookifyModelKit"]),
    ],
    targets: [
        .target(
            name: "BookifyModelKit",
            path: "Sources/Models",
            sources: ["Hotels","Places", "Configuration"]
        ),
        .testTarget(
            name: "BookifyModelKitTests",
            dependencies: ["BookifyModelKit"], path: "Tests"
        ),
    ]
)


