// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "headsUp",
    platforms: [.macOS(.v14)],
    targets: [
        .executableTarget(
            name: "headsUp",
            path: "code"
        )
    ]
) 
