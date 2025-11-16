// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BookifyDomainKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "BookifyDomainKit",
            targets: ["BookifyDomainKit"]
        ),
    ],
    dependencies: [
        .package(name: "BookifyModelKit", path: "../BookifyModelKit"),
        .package(url: "https://github.com/Radhach9027/NetworkClient", branch: "main")
    ],
    targets: [
        .target(
            name: "BookifyDomainKit",
            dependencies: [
                .product(name: "NetworkClient", package: "NetworkClient"),
                .product(name: "BookifyModelKit", package: "BookifyModelKit")
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "BookifyDomainKitTests",
            dependencies: ["BookifyDomainKit"]
        ),
    ]
)
