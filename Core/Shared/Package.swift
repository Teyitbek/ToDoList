// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Shared",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "Fonts", targets: ["Fonts"]),
        .library(name: "Extensions", targets: ["Extensions"]),
        .library(name: "AppContainer", targets: ["AppContainer"]),
        .library(name: "Constants", targets: ["Constants"]),
        .library(name: "Data", targets: ["Data"]),
        .library(name: "Domain", targets: ["Domain"]),
        .library(name: "Session", targets: ["Session"]),
        .library(name: "TableView", targets: ["TableView"]),
        .library(name: "Base", targets: ["Base"]),
        .library(name: "Assets", targets: ["Assets"]),
        .library(name: "KeyboardManager", targets: ["KeyboardManager"])
    ],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Factory", from: "2.4.3"),
        .package(url: "https://github.com/immobiliare/RealHTTP", from: "1.9.0"),
        .package(url: "https://github.com/devicekit/DeviceKit.git", from: "5.6.0"),
        .package(name: "ActivityIndicator", path: "ActivityIndicator")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "Fonts", resources: [.process("Roboto"),
                                           .process("Murecho"),
                                           .process("Murecho.plist"),
                                           .process("Roboto.plist")]),
        .target(name: "Extensions", dependencies: ["RealHTTP",
                                                   "DeviceKit"]),
        .target(name: "AppContainer", dependencies: ["Factory",
                                                     "Session",
                                                     "RealHTTP",
                                                     "Data",
                                                     "Domain"]),
        .target(name: "Constants", dependencies: ["Extensions"]),
        .target(name: "Domain"),
        .target(name: "Data", dependencies: ["Domain",
                                             "RealHTTP",
                                             "Extensions"]),
        .target(name: "Session", dependencies: ["Domain"]),
        .target(name: "KeyboardManager"),
        .target(name: "TableView", dependencies: ["Extensions", "Constants"]),
        .target(name: "Base", dependencies: ["ActivityIndicator", "Domain", "KeyboardManager", "AppContainer"]),
        .target(name: "Assets", dependencies: ["Domain"], resources: [.process("Colors.xcassets")])
    ]
)
