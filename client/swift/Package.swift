import PackageDescription

let package = Package(
  name: "Coop",
  dependencies: [
    .Package(url: "https://github.com/Zewo/HTTPClient.git", majorVersion: 0, minor: 13)
  ]
)
