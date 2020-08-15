// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "swift-crypto-authorship",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(
            name: "Identify",
            targets: ["Identify"]),
        .library(
            name: "EllipticCurveIdentification",
            targets: ["EllipticCurveIdentification"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-crypto", .exact("1.0.2")),
        .package(url: "https://github.com/apple/swift-log", .upToNextMajor(from: "1.0.0")),
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
