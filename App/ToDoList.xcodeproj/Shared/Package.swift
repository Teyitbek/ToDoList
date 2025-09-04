// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// swiftlint:disable all
let package = Package(
    name: "Shared",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "Fonts", targets: ["Fonts"]),
        .library(name: "Extensions", targets: ["Extensions"]),
        .library(name: "Localizations", targets: ["Localizations"]),
        .library(name: "Session", targets: ["Session"])
    ],
    dependencies: [.package(url: "https://github.com/hmlongco/Factory", branch: "main")],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "Fonts", resources: [.process("Inter"),
                                               .process("Ubuntu"),
                                               .process("Inter.plist"),
                                               .process("Ubuntu.plist")]),
        .target(name: "Extensions", dependencies: ["Factory"]),
        .target(name: "Localizations"),
        .target(name: "Session",
                dependencies: [])
    ]
)
// swiftlint:enable all
