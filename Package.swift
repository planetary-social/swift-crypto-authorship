// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "swift-crypto-authorship",
    products: [
        .library(
            name: "Identify",
            targets: ["Identify"]),
    ],
    targets: [
        .target(
            name: "Identify",
            dependencies: []),
    ]
)
