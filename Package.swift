// swift-tools-version:5.9
import PackageDescription

let package = Package(
  name: "convert",
  platforms: [
    .macOS(.v12)
  ],
  products: [
    .executable(name: "convert", targets: ["convert"])
  ],
  dependencies: [
    .package(url: "https://github.com/AdguardTeam/SafariConverterLib.git", from: "2.0.31")
  ],
  targets: [
    .executableTarget(
      name: "convert",
      dependencies: [
        .product(name: "ContentBlockerConverter", package: "SafariConverterLib")
      ]
    )
  ]
)
