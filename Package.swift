// swift-tools-version: 5.5
import PackageDescription

let package = Package(
  name: "ide-icons",
  platforms: [
    .macOS(.v12),
    .iOS(.v15),
    .watchOS(.v8),
    .tvOS(.v15),
  ],
  products: [
    .library(name: "IDEIcons", targets: ["IDEIcons"]),
  ],
  targets: [
    .target(name: "IDEIcons"),
  ]
)
