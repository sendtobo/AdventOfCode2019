// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode2019",
    products: [
        .library(
            name: "AdventOfCode2019",
            targets: ["AdventOfCode2019"]),
    ],
    targets: [
        .target(name: "AdventOfCode2019",
                dependencies: []),
        .testTarget(
            name: "AdventOfCode2019Tests",
            dependencies: ["AdventOfCode2019"]),
    ]
)
