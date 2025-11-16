// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Hotels",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Hotels",
            targets: ["Hotels"]
        ),
    ],
    dependencies: [
        .package(path: "../BookifyDomainKit")
    ],
    targets: [
        .target(
            name: "Hotels",
            dependencies: [
                .product(name: "BookifyDomainKit", package: "BookifyDomainKit")
            ],
            path: "Sources/Hotels"
        ),
        .testTarget(
            name: "HotelsTests",
            dependencies: ["Hotels"]
        ),
    ]
)
