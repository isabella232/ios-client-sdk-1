
// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.
// THIS FILE IS AUTOGENERATED

import PackageDescription

let package = Package(
    name: "bluejeans-ios-client-sdk",

    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "bluejeans-ios-client-sdk",
            targets: ["bluejeans-ios-client-sdk"]),
        .library(
            name: "bluejeans-ios-client-sdk-simulator",
            targets: ["bluejeans-ios-client-sdk-simulator"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "bluejeans-ios-client-sdk",dependencies: [ "dvclient", "Reachability", "VZXRCVCommon", "VZXRCVVideoEffects", "VZXRCVFeatureVirtualBackgrounds", "BJNiOSBroadcastExtension", "BJNClientCore", "BJNClientBaseCore", "bjnmediacapturer", "PubNub", "BJNAPIClient", "Swinject", "SocketRocket", "fiberClient", "BJNHTTP", "koko", "fiber", "Mixpanel", "BJNiOSCore", "BJNClientSDK", "videoeffects", "MMWormhole", "CocoaLumberjackSwift", "CocoaLumberjack",]),        .target(
            name: "bluejeans-ios-client-sdk-simulator",dependencies: [ "dvclient", "Reachability", "BJNiOSBroadcastExtension", "BJNClientCore", "BJNClientBaseCore", "bjnmediacapturer", "PubNub", "BJNAPIClient", "Swinject", "SocketRocket", "fiberClient", "BJNHTTP", "koko", "fiber", "Mixpanel", "BJNiOSCore", "BJNClientSDK", "videoeffects", "MMWormhole", "CocoaLumberjackSwift", "CocoaLumberjack",]),        .binaryTarget(name: "dvclient", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/dvclient.zip", checksum: "2e6c75ccbb7ede758fbfa63719ddac4487f35e59cccd93ad1cb7560cc9d8450d"),
        .binaryTarget(name: "Reachability", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/Reachability.zip", checksum: "d4b381722e508681141e2ad90dd71d7c2f0f7a6631fee77d24f2af0a563b3755"),
        .binaryTarget(name: "VZXRCVCommon", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/VZXRCVCommon.zip", checksum: "e9504244fb543bcabe1dc00e57309d666e0b80ba372d2a441faceb13a4c3ed92"),
        .binaryTarget(name: "VZXRCVVideoEffects", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/VZXRCVVideoEffects.zip", checksum: "3968b3fdf8df35bc45dc91c95f6600e3e9b5da4918692229d34bbca2d68c1d8b"),
        .binaryTarget(name: "VZXRCVFeatureVirtualBackgrounds", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/VZXRCVFeatureVirtualBackgrounds.zip", checksum: "8a7bba13ebc2fa04bb93fc7c8b724bb4962c28d57326823f83bf977c3623b0b2"),
        .binaryTarget(name: "BJNiOSBroadcastExtension", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/BJNiOSBroadcastExtension.zip", checksum: "e8e10a457bd6ae4dc6c79bcd1c1237632fb5f4603b5d78666e084d12c7c1a637"),
        .binaryTarget(name: "BJNClientCore", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/BJNClientCore.zip", checksum: "21db4898e5316907f9c2ae812bfe286b00ada4856454506322b361cbfcc19b8a"),
        .binaryTarget(name: "BJNClientBaseCore", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/BJNClientBaseCore.zip", checksum: "15ba12ee4aa87df30514a3dd9856e3d94dfcf8709138895e2d2103db3a850876"),
        .binaryTarget(name: "bjnmediacapturer", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/bjnmediacapturer.zip", checksum: "4843f3247581e2c13341eb000291b5106d7ec60d8dbdb27ee6c48d0b6c275ca5"),
        .binaryTarget(name: "PubNub", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/PubNub.zip", checksum: "f0357a031b8e600dc1b7298ab905e87f7d845bd906e43345bd6db85aedaf5f66"),
        .binaryTarget(name: "BJNAPIClient", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/BJNAPIClient.zip", checksum: "ec5a5143e0eee3a148699be989ed5f3fc8993eb3f62ba3a94b897f2f32d1a6bc"),
        .binaryTarget(name: "Swinject", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/Swinject.zip", checksum: "f95227b2e3cafb934c42935dee9390927c2d8d0c3a295c8bff572e71436e6284"),
        .binaryTarget(name: "SocketRocket", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/SocketRocket.zip", checksum: "b4107c720ac25bb507e70514cfe164e1c224ae50a7eea1e8c2b8a64c2dbcbd17"),
        .binaryTarget(name: "fiberClient", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/fiberClient.zip", checksum: "f706924c8d6b3ec8611115529f713334c752b4bb72b9e5bb61465e41b75eb9e7"),
        .binaryTarget(name: "BJNHTTP", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/BJNHTTP.zip", checksum: "808f2132898fb0fe21b848adab8bb3325fc0aadf593d121d817070e8ca2d1e7e"),
        .binaryTarget(name: "koko", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/koko.zip", checksum: "08a079645388ef14a04679c653edf06c6f39600bd13fd964a41d1c0661becfe4"),
        .binaryTarget(name: "fiber", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/fiber.zip", checksum: "8ee754eabfedcb64894dfb3e87fb0ef6821617354ab682fb6380a62bd7c52953"),
        .binaryTarget(name: "Mixpanel", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/Mixpanel.zip", checksum: "8c921cf59e1e290b2e0fb8717b624603f0e5b7d3703e8a460fc68a580925a8cd"),
        .binaryTarget(name: "BJNiOSCore", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/BJNiOSCore.zip", checksum: "ab77fb2198e4e477ed391874fcd14ab1fd5a0fd32e9145b57571ef88ffc2c5c3"),
        .binaryTarget(name: "BJNClientSDK", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/BJNClientSDK.zip", checksum: "aafe8abef12d3ebe111092c07c92d55e8ed589fab2e5b86308b8fb527e3d6feb"),
        .binaryTarget(name: "videoeffects", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/videoeffects.zip", checksum: "6aff473a32321622dda13b12342f5d49bff4835f8d7d3509df4be330faf1bc60"),
        .binaryTarget(name: "MMWormhole", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/MMWormhole.zip", checksum: "dbb623e2efdcdfb1adeddbd571cee2a7020cb5620525a464c0cfc022c62c4d09"),
        .binaryTarget(name: "CocoaLumberjackSwift", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/CocoaLumberjackSwift.zip", checksum: "59ad7fed4598eacdb6f390a1583edd1580102d22f9c6ac741d401a1f11f40344"),
        .binaryTarget(name: "CocoaLumberjack", url: "https://swdl.bluejeans.com/bjnvideosdk/ios/1.3.0/SPM_Frameworks/CocoaLumberjack.zip", checksum: "740459d089fc5b05fb77a44efb18abb54f59c725b8971e034f7e5a8b870c6cfe"),    ]
)

