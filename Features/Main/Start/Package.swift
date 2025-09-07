// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Start",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Start",
            targets: ["StartPresentation", "StartDI"])
    ],
    dependencies: [.package(name: "Shared", path: "Shared"),
                   .package(name: "TextField", path: "TextField"),
                   .package(name: "ActivityIndicator", path: "ActivityIndicator")],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "StartPresentation",
                dependencies: [
                    "StartDomain",
                    "StartData",
                    "TextField",
                    "ActivityIndicator",
                    .product(name: "TableView", package: "Shared"),
                    .product(name: "Domain", package: "Shared"),
                    .product(name: "Extensions", package: "Shared"),
                    .product(name: "Fonts", package: "Shared"),
                    .product(name: "Base", package: "Shared"),
                    .product(name: "Constants", package: "Shared")]),
        .target(name: "StartDomain",
                dependencies: [
                    .product(name: "Data", package: "Shared"),
                    .product(name: "Domain", package: "Shared")]),
        .target(name: "StartData",
                dependencies: ["StartDomain",
                               .product(name: "Data", package: "Shared"),
                               .product(name: "Extensions", package: "Shared"),
                               .product(name: "Domain", package: "Shared")]),
        .target(name: "StartDI",
                dependencies: ["StartDomain",
                               "StartData",
                               .product(name: "AppContainer", package: "Shared"),
                               .product(name: "Domain", package: "Shared")])
    ]
)
