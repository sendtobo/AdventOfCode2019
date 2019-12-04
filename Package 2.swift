// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift
// required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode",
    dependencies: [
        .package(url: "https://github.com/apple/swift-package-manager.git",
                 from: "0.5.0"),
        .package(url: "https://github.com/JohnSundell/Files", from: "4.0.0"),
    ],
    targets: [
        .target(
            name: "AdventOfCode",
            dependencies: ["SPMUtility", "Files"])
    ]
)
