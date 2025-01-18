//
//  AppMarketManifest.swift
//
//  Created by Garth on 11/1/21.
//  Copyright © 2022 Neat Software Co. All rights reserved.
//

import Foundation

public struct AppMarketManifest {
    static let macOS: [AppMarketApp] = [
        .init(
            appStoreId: "1449619230",
            bundleId: "neat.software.Tim",
            title: "Tim • Time Tracker",
            subtitle: "Simple, Powerful Time Tracking for macOS",
            image: "tim-icon-128x128",
            imageIsPrecomposed: true,
            websiteUrl: URL(string: "https://tim.neat.software")
        ),
        .init(
            appStoreId: "1532271726",
            bundleId: "neat.software.Ping",
            title: "Ping • Uptime Monitor",
            subtitle: "Website & Network Uptime Monitor for macOS",
            image: "ping-icon-128x128",
            imageIsPrecomposed: true,
            websiteUrl: URL(string: "https://ping.neat.software")
        )
    ]

    static let iOS: [AppMarketApp] = [
        .init(
            appStoreId: "6740147063",
            bundleId: "neat.software.ColorPal",
            title: "Color Pal",
            subtitle: "AI Coloring Pages for iOS",
            image: "colorpal-icon-80x80",
            imageIsPrecomposed: false,
            websiteUrl: URL(string: "https://colorpal.neat.software")
        ),
        .init(
            appStoreId: "1538046066",
            bundleId: "neat.software.Jot",
            title: "Jot • Sticky Note Widgets",
            subtitle: "Draw Notes on your iOS Home & Lock Screens",
            image: "jot-icon-80x80",
            imageIsPrecomposed: false,
            websiteUrl: URL(string: "https://jot.neat.software")
        ),
        .init(
            appStoreId: "6461776692",
            bundleId: "neat.software.RadTimer",
            title: "Rad Timer",
            subtitle: "Multiple Timers & Widgets for all Apple Devices",
            image: "rad-icon-80x80",
            imageIsPrecomposed: false,
            websiteUrl: URL(string: "https://rad.neat.software")
        )
    ]
}

public extension AppMarketManifest {
    static let all = macOS + iOS
    static let allButSelf: [AppMarketApp] = {
        let thisBundleId = Bundle.main.bundleIdentifier?.lowercased() ?? ""
        return all.filter({ $0.bundleId.lowercased() != thisBundleId })
    }()

    static func random(manifest: [AppMarketApp] = all) -> AppMarketApp {
        if manifest.count <= 1 { return manifest[0] }
        let thisBundleId = Bundle.main.bundleIdentifier?.lowercased() ?? ""
        var randomItem = manifest.randomElement()
        while randomItem?.bundleId.lowercased() == thisBundleId {
            randomItem = manifest.randomElement()
        }
        return randomItem ?? manifest[0]
    }
}
