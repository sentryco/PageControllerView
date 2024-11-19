// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "PageControllerView",
    platforms: [
        .macOS(.v15) // macOS 14 and later
    ],
    products: [
        .library(
            name: "PageControllerView",
            targets: ["PageControllerView"])
    ],
    targets: [
        .target(
            name: "PageControllerView"),
        .testTarget(
            name: "PageControllerViewTests",
            dependencies: ["PageControllerView"])
    ]
)
