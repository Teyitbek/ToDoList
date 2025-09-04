// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swiftlint:disable all
import PackageDescription

let package = Package(
    name: "Splash",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "Splash", targets: ["Splash"]),
    ],
    dependencies: [.package(name: "Shared", path: "Shared")],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "Splash",
                dependencies: [ "SplashDomain",
                                .product(name: "Extensions", package: "Shared")]),
        .target(name: "SplashDomain")
    ]
)
// swiftlint:enable all
