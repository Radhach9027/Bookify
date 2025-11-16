// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BookifyAuthentication",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "BookifyAuthentication",
            targets: ["BookifyAuthentication"]
        ),
    ],
    dependencies: [.package(name: "BookifySharedSystem", path: "../BookifySharedSystem")],
    targets: [
        .target(
            name: "BookifyAuthentication",
            dependencies: [
                .product(name: "BookifySharedSystem", package: "BookifySharedSystem")
            ]
        ),
        .testTarget(
            name: "BookifyAuthenticationTests",
            dependencies: ["BookifyAuthentication"]
        ),
    ]
)
