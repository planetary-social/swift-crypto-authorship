// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "swift-crypto-authorship",
    products: [
        .library(
            name: "Identify",
            targets: ["Identify"]),
        .library(
            name: "EllipticCurveIdentification",
            targets: ["EllipticCurveIdentification"]),
    ],
    targets: [
        .target(
            name: "Identify",
            dependencies: []),
        .target(
            name: "EllipticCurveIdentification",
            dependencies: [
                "Identify",
                .product(name: "Crypto", package: "swift-crypto"),
                .product(name: "Logging", package: "swift-log"),
            ]),
    ]
)
