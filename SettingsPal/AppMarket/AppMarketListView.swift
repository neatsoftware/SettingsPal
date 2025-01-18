//
//  AppMarketListView.swift
//
//  Created by garth on 8/15/24.
//  Copyright © 2024 Neat Software Co. All rights reserved.
//

import SwiftUI

public struct AppMarketListView: View {
    public let apps: [AppMarketApp]

    public init(apps: [AppMarketApp] = AppMarketManifest.allButSelf) {
        self.apps = apps
    }

    public var body: some View {
        DividedVStack {
            ForEach(apps) { app in
                ItemView(app: app)
            }
        }
    }
}

private struct ItemView: View {
    let app: AppMarketApp

    var body: some View {
        Button(action: {
            app.appStoreUrl(placement: "list")?.open()
        }, label: {
            AppMarketAppView(app: app)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(6)
                .contentShape(Rectangle())
        })
        .buttonStyle(.plain)
    }
}
