// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Bookings",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Bookings",
            targets: ["Bookings"]
        ),
    ],
    targets: [
        .target(
            name: "Bookings",
            path: "Sources/Bookings/Setup"
        ),
        .testTarget(
            name: "BookingsTests",
            dependencies: ["Bookings"]
        ),
    ]
)
