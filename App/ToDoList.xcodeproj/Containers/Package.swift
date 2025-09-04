// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// swiftlint:disable all
let package = Package(
    name: "Containers",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "AppContainer", targets: ["AppContainer"])
    ],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Factory", branch: "main"),
        .package(name: "Shared", path: "../Shared"),
        .package(url: "https://github.com/slackhq/PanModal", branch: "master"),
        .package(name: "Coordinators", path: "../Coordinators")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "AppContainer",
                dependencies: ["Factory",
                               "PanModal",
                               .product(name: "LaunchInstructor", package: "Coordinators"),
                               .product(name: "AppCoordinator", package: "Coordinators"),
                               .product(name: "Session", package: "Shared")])
    ]
)
// swiftlint:enable all
