// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FTFeatures",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "FTFeatures",
            targets: ["FTFeatures"]
        ),
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../FTData"),
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            from: "1.9.0"
        )
    ],
    targets: [
        .target(
            name: "FTFeatures",
            dependencies: [
                "Domain",
                "FTData",
                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture"
                )
            ],
            path: "Sources/FTFeatures"
        ),
    ]
)
