// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EmptyPage",
    platforms: [.iOS(.v9)],
    products: [
        .library(name: "EmptyPage", targets: ["EmptyPage"]),
    ],
    targets: [
        .target(
            name: "EmptyPage",
            path: "Sources",
            sources: ["Core", "managers", "Standard"])
    ]
)
