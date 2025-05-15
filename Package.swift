// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "WeatherApp",
    platforms: [
        .macOS(.v13), .iOS(.v16)
    ],
    products: [
        .executable(name: "WeatherApp", targets: ["WeatherApp"]),
    ],
    targets: [
        .executableTarget(
            name: "WeatherApp"
        ),
        .testTarget(
            name: "WeatherAppTests",
            dependencies: ["WeatherApp"]
        )
    ]
)

