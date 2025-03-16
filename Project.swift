import ProjectDescription

let project = Project(
    name: "Boomerang",
    targets: [
        .target(
            name: "Boomerang",
            destinations: .iOS,
            product: .app,
            bundleId: "com.outlook",
            infoPlist: .file(path: "Boomerang/Info.plist"),
            sources: ["Boomerang/**"],
            resources: ["Boomerang/Assets.xcassets"],
            dependencies: []
        ),
//        .target(
//            name: "BoomerangTests",
//            destinations: .iOS,
//            product: .unitTests,
//            bundleId: "com.outlook",
//            infoPlist: .default,
//            sources: ["Tests/**"],
//            dependencies: [.target(name: "Boomerang")]
//        )
    ]
)

