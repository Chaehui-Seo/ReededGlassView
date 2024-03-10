// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReededGlassEffectView",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "ReededGlassEffectView",
            targets: ["ReededGlassEffectView"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ReededGlassEffectView",
            dependencies: []),
        .testTarget(
            name: "ReededGlassEffectViewTests",
            dependencies: ["ReededGlassEffectView"]),
    ]
)
