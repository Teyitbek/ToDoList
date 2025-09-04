// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Pincode",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Pincode",
            targets: ["PincodePresentation", "PincodeDI"])
    ],
    dependencies: [.package(name: "Shared", path: "Shared"),
                   .package(name: "TextField", path: "TextField"),
                   .package(url: "https://github.com/hmlongco/Factory", branch: "main"),
                   .package(name: "ActivityIndicator", path: "ActivityIndicator")],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "PincodePresentation",
                dependencies: [
                    "PincodeDomain",
                    "TextField",
                    "ActivityIndicator",
                    .product(name: "Domain", package: "Shared"),
                    .product(name: "Fonts", package: "Shared"),
                    .product(name: "Extensions", package: "Shared"),
                    .product(name: "Constants", package: "Shared"),
                    .product(name: "Base", package: "Shared"),
                    .product(name: "LocalizationManager", package: "Shared"),
                    .product(name: "KeyboardManager", package: "Shared")]),
        .target(name: "PincodeDomain", dependencies: [.product(name: "Domain", package: "Shared")]),
        .target(name: "PincodeData", dependencies: ["PincodeDomain",
                                                    .product(name: "Data", package: "Shared")]),
        .target(name: "PincodeDI", dependencies: ["PincodeData",
                                                  "PincodeDomain",
                                                  "Factory",
                                                  .product(name: "AppContainer", package: "Shared")]),
        .testTarget(name: "PincodeDomainTests", dependencies: ["PincodeDomain", .product(name: "Domain", package: "Shared")]),
    ]
)
