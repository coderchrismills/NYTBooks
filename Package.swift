// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NYTBooks",
    platforms: [.macOS(.v10_12)],
    products: [
        .executable(name: "nytb", targets: ["NYTBooks"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "0.3.0")),
        .package(url: "https://github.com/mxcl/Chalk.git", from: "0.1.0"),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "4.0.0"),
        .package(url: "https://github.com/JanGorman/Table", from: "1.0.0"),
        .package(url: "https://github.com/scottrhoyt/SwiftyTextTable.git", from: "0.5.0")
    ],
    targets: [
        .target(name: "NYTBooks", dependencies: [
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
            .product(name: "Chalk", package: "Chalk"),
            .product(name: "SwiftyJSON", package: "SwiftyJSON"),
            .product(name: "Table", package: "Table"),
            .product(name: "SwiftyTextTable", package: "SwiftyTextTable")
        ])
    ]
)
