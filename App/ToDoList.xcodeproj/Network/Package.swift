// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// swiftlint:disable all
let package = Package(
    name: "Network",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "Requests", targets: ["Requests"]),
    ],
    dependencies: [.package(url: "https://github.com/immobiliare/RealHTTP", branch: "main"),
                   .package(name: "Logger", path: "../Logger")],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "Shared", dependencies: ["RealHTTP", "Logger"]),
        .target(name: "Requests", dependencies: ["Logger"])
    ]
)
// swiftlint:enable all
