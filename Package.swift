// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReededGlassView",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "ReededGlassView",
            targets: ["ReededGlassView"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ReededGlassView",
            dependencies: []),
        .testTarget(
            name: "ReededGlassViewTests",
            dependencies: ["ReededGlassView"]),
    ]
)
