//
//  AppMarketAdView.swift
//
//  Created by Garth on 11/1/21.
//  Copyright © 2022 Neat Software Co. All rights reserved.
//

import SwiftUI

public struct AppMarketAdView: View {
    public let app: AppMarketApp
    @State private var isHovering = false

    public init(app: AppMarketApp) {
        self.app = app
    }

    public var body: some View {
        Button(action: {
            app.appStoreUrl(placement: "ad")?.open()
        }, label: {
            HStack(spacing: 6) {
                AppMarketAppView(app: app)
                Spacer()
                Text("Ad")
                    .foregroundColor(.white)
                    .font(.system(size: 11, weight: .semibold))
                    .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .background(
                        RoundedRectangle(cornerRadius: 6, style: .continuous).fill(Color.secondary.opacity(0.7))
                    )
            }
            .padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 12))
            .background(Color.gray.opacity(isHovering ? 0.12 : 0.08))
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.2), lineWidth: 1))
            .contentShape(RoundedRectangle(cornerRadius: 10))
            .onHover { isHovering = $0 }
        }).buttonStyle(.plain)
    }
}

public struct AppMarketAdListSectionView: View {
    public let app: AppMarketApp
    public init(app: AppMarketApp) {
        self.app = app
    }

    public var body: some View {
        Section {
            AppMarketAdView(app: app)
        }.listRowBackground(Color.clear).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}
