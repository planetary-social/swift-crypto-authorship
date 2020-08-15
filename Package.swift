// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "swift-crypto-authorship",
    products: [
        .library(
            name: "Identify",
            targets: ["Identify"]),
        .library(
            name: "CombineTrusted",
            targets: ["CombineTrusted"]),
    ],
    targets: [
        .target(
            name: "Identify",
            dependencies: []),
        .target(
            name: "CombineTrusted",
            dependencies: [
                "Identify",
            ]),
        .testTarget(
            name: "CombineTrustedTests",
            dependencies: [
                "Identify",
                "CombineTrusted",
                "EllipticCurveIdentification"
            ]),
    ]
)
