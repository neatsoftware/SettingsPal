//
//  AppMarketApp.swift
//
//  Created by Garth on 11/1/21.
//  Copyright © 2022 Neat Software Co. All rights reserved.
//

import Foundation

public struct AppMarketApp {
    let appStoreId: String
    let bundleId: String
    let title: String
    let subtitle: String
    let image: String
    let imageIsPrecomposed: Bool
    let websiteUrl: URL?
}

extension AppMarketApp: Identifiable {
    public var id: String {
        appStoreId
    }

    public func appStoreUrl(placement: String) -> URL? {
        let pt = "515396"
        let ct = Bundle.main.appName.replacingOccurrences(of: " ", with: "-").lowercased() + "-" + placement
        return URL(string: "https://apps.apple.com/app/id\(appStoreId)?pt=\(pt)&ct=\(ct)")
    }
}

private extension Bundle {
    var appName: String { return infoDictionary?[kCFBundleNameKey as String] as? String ?? "" }
}
