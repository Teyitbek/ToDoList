// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Splash",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "Splash", targets: ["SplashPresentation", "SplashDI"]),
    ],
    dependencies: [.package(name: "Shared", path: "Shared"),
                   .package(name: "ActivityIndicator", path: "ActivityIndicator"),
                   .package(url: "https://github.com/hmlongco/Factory", branch: "main")],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "SplashPresentation",
                dependencies: [ "SplashDomain",
                                "SplashData",
                                "ActivityIndicator",
                                .product(name: "Extensions", package: "Shared"),
                                .product(name: "Base", package: "Shared"),
                                .product(name: "Fonts", package: "Shared")]),
        .target(name: "SplashDomain", dependencies: [.product(name: "Domain", package: "Shared")]),
        .target(name: "SplashData", dependencies: ["SplashDomain",
                                                   "Factory",
                                                   .product(name: "Domain", package: "Shared"),
                                                   .product(name: "Data", package: "Shared"),
                                                   .product(name: "Extensions", package: "Shared")]),
        .target(name: "SplashDI", dependencies: ["SplashData",
                                                 "Factory",
                                                 .product(name: "AppContainer", package: "Shared"),
                                                 .product(name: "Domain", package: "Shared")])
    ]
)
