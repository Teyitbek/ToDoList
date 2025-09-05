// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swiftlint:disable all

import PackageDescription

let package = Package(
    name: "Coordinators",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "AppCoordinator", targets: ["AppCoordinator"]),
        .library(name: "LaunchInstructor", targets: ["LaunchInstructor"]),
        .library(name: "AppLauncher", targets: ["AppLauncher"])
    ],
    dependencies: [.package(name: "Splash", path: "Splash"),
                   .package(name: "Start", path: "Start"),
                   .package(name: "Pincode", path: "Pincode"),
                   .package(name: "Details", path: "Details"),
                   .package(name: "Shared", path: "Shared")],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "AppCoordinator",
                dependencies: ["SplashCoordinator",
                               "AuthCoordinator",
                               "LaunchInstructor",
                               "MainCoordinator",
                               "Coordinator"]),
        .target(name: "AuthCoordinator",
                dependencies: ["Pincode",
                               "Coordinator"]),
        .target(name: "SplashCoordinator",
                dependencies: ["Splash",
                               "Coordinator"]),
        .target(name: "MainCoordinator",
                dependencies: ["Start",
                               "Details",
                               "Coordinator"]),
        .target(name: "Coordinator", dependencies: [.product(name: "Domain", package: "Shared")]),
        .target(name: "LaunchInstructor", dependencies: [.product(name: "Domain", package: "Shared")]),
        .target(name: "AppLauncher", dependencies: ["Coordinator",
                                                    "AppCoordinator",
                                                    "LaunchInstructor",
                                                    "MainCoordinator",
                                                    .product(name: "AppContainer", package: "Shared"),
                                                    .product(name: "Domain", package: "Shared")])
    ]
)
