import PackageDescription

let package = Package(
    name: "AssistantBot",
    dependencies: [
        .Package(url: "https://github.com/SlackKit/SlackKit.git", majorVersion: 4),
        ]
)
