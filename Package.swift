// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "async_cached_image",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name:"AsyncCachedImage",targets:["AsyncCachedImage"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "AsyncCachedImage", dependencies: []),
    ]
)
