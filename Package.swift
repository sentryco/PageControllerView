// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "PageControllerView",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "PageControllerView",
            targets: ["PageControllerView"]),
    ],
    targets: [
        .target(
            name: "PageControllerView"),
        .testTarget(
            name: "PageControllerViewTests",
            dependencies: ["PageControllerView"]),
    ]
)