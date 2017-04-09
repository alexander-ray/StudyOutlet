import PackageDescription

let package = Package(
    name: "StudyOutlet",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 5),
        .Package(url: "https://github.com/vapor/mysql-provider.git", majorVersion: 1, minor: 0),
        .Package(url:"https://github.com/siemensikkema/vapor-jwt.git", majorVersion: 0, minor: 4),
    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
        "Tests",
    ]
)

