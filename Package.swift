// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Reachable",
    platforms: [
        .iOS(.v12), .macOS(.v10_14)
    ],
    products: [
        .library(
            name: "Reachable",
            targets: ["Reachable"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/ReactiveX/RxSwift.git",
            .upToNextMajor(from: "6.0.0")
        )
    ],
    targets: [
        .target(
            name: "Reachable",
            dependencies: [
                .product(name: "RxSwift", package: "RxSwift")
            ]
        ),
        .testTarget(
            name: "ReachableTests",
            dependencies: [
                "Reachable"
            ]
        )
    ]
)
