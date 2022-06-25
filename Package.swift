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
  dependencies: [
    .package(url: "https://github.com/freyaariel/previews-capture.git", branch: "main"),
    .package(url: "https://github.com/yannickl/DynamicColor.git", from: "5.0.1"), // TODO: get rid of this
  ],
  targets: [
    .target(name: "IDEIcons", dependencies: [
      .product(name: "PreviewsCapture", package: "previews-capture"),
      .product(name: "DynamicColor", package: "DynamicColor"),
    ]),
  ]
)
