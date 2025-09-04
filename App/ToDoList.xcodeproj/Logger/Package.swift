// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// swiftlint:disable all
let package = Package(
    name: "Logger",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Logger",
            targets: ["Logger"]),
    ],
    dependencies: [.package(url: "https://github.com/getsentry/sentry-cocoa", from: "8.22.2"),
                   .package(name: "Shared", path: "Shared")],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "Logger",
                dependencies: [.product(name: "Sentry", package: "sentry-cocoa")]),
        .testTarget(
            name: "LoggerTests",
            dependencies: ["Logger", .product(name: "Session", package: "Shared")]),
    ]
)
// swiftlint:enable all
