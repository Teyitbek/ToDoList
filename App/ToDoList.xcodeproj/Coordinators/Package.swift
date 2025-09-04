// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// swiftlint:disable all
let package = Package(
    name: "Coordinators",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "AppCoordinator", targets: ["AppCoordinator"]),
        .library(name: "LaunchInstructor", targets: ["LaunchInstructor"])
    ],
    dependencies: [.package(name: "Splash", path: "Splash"),
                   .package(name: "Login", path: "Login"),
                   .package(url: "https://github.com/slackhq/PanModal", branch: "master"),
                   .package(name: "Shared", path: "Shared")],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "AuthCoordinator",
                dependencies: ["Splash",
                               "Login",
                               "Coordinator"]),
        .target(name: "AppCoordinator",
                dependencies: ["AuthCoordinator",
                               "LaunchInstructor",
                               "Coordinator"]),
        .target(name: "Coordinator", dependencies: ["PanModal"]),
        .target(name: "LaunchInstructor", 
                dependencies: [.product(name: "Session", package: "Shared")])
    ]
)
// swiftlint:enable all
