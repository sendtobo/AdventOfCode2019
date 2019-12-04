// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "adventOfCode2019",
    dependencies: [
        .package(url: "https://github.com/apple/swift-package-manager.git",
                 from: "0.5.0"),
        .package(url: "https://github.com/JohnSundell/Files", from: "4.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "adventOfCode2019",
            dependencies: ["SPMUtility", "Files"]),
        .testTarget(
            name: "adventOfCode2019Tests",
            dependencies: ["adventOfCode2019"]),
    ]
)
