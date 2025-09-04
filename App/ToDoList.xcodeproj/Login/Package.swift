// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// swiftlint:disable all
let package = Package(
    name: "Login",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Login",
            targets: ["Login"])
    ],
    dependencies: [.package(name: "Shared", path: "Shared"),
                   .package(url: "https://github.com/SwiftKickMobile/SwiftMessages", branch: "master")],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "Login",
                dependencies: ["LoginDomain",
                               "SwiftMessages",
                               .product(name: "Extensions", package: "Shared")]),
        .target(name: "LoginDomain"),
        .target(name: "LoginInfrastructure", dependencies: ["LoginDomain"]),
        .target(name: "LoginUseCases", dependencies: ["LoginDomain"])
    ]
)
// swiftlint:enable all
