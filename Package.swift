// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "adventOfCode2019",
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Files", from: "4.0.0"),
    ],
    targets: [
        .target(name: "adventOfCode2019",
                dependencies: ["Files"]),
        .testTarget(
            name: "adventOfCode2019Tests",
            dependencies: ["adventOfCode2019"]),
    ]
)
