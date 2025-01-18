//
//  AppMarketAppView.swift
//
//  Created by garth on 8/15/24.
//  Copyright © 2024 Neat Software Co. All rights reserved.
//

import SwiftUI

public struct AppMarketAppView: View {
    public let app: AppMarketApp
    public init(app: AppMarketApp) {
        self.app = app
    }

    public var body: some View {
        HStack(spacing: 6) {
            let imageView = Image(app.image).resizable()
            if app.imageIsPrecomposed {
                imageView.frame(width: 42, height: 42)
            } else {
                imageView
                    .frame(width: 34, height: 34)
                    .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                    .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                    .padding(4)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(app.title).font(.system(size: 14, weight: .semibold)).foregroundColor(.primary)
                Text(app.subtitle).font(.system(size: 11)).foregroundColor(.secondary)
            }
        }
    }
}
