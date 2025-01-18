//
//  Theme.swift
//  Settings Pal
//
//  Created by @gpoitch on 6/2/24.
//

import SwiftUI

enum Theme: Int, CaseIterable {
    case classic, modern

    #if APP_STORE
    // App Store won't allow redistributing the classic icon images
    static let `default` = Theme.modern
    static let allCases: [Theme] = [.modern]
    #else
    static let `default` = Theme.classic
    #endif

    var title: String {
        switch self {
        case .classic: "Classic"
        case .modern: "Modern"
        }
    }

    var useTileIcon: Bool {
        switch self {
        case .classic: true
        case .modern: false
        }
    }

    @ViewBuilder
    var backgroundView: some View {
        switch self {
        case .classic: Color.clear
        case .modern: MaterialView(material: .underWindowBackground)
        }
    }

    var tileTextColor: Color {
        switch self {
        case .classic: .secondary
        case .modern: .primary
        }
    }

    var tileTextColorPressed: Color {
        switch self {
        case .classic: .primary
        case .modern: .primary
        }
    }

    var tilePressedBlendMode: Bool {
        switch self {
        case .classic: true
        case .modern: false
        }
    }

    var tileContentSpacing: CGFloat {
        switch self {
        case .classic: 4
        case .modern: 6
        }
    }

    var tileColumnSpacing: CGFloat {
        switch self {
        case .classic: 3
        case .modern: 8
        }
    }

    var tileHoverEffect: Bool {
        switch self {
        case .modern: true
        default: false
        }
    }

    @ViewBuilder
    var userPaneBgView: some View {
        switch self {
        case .classic: Color.clear
        case .modern: Color.gray.opacity(0.085)
        }
    }

    var alternatingPaneBgColor: Color? {
        switch self {
        case .classic: .secondary.opacity(0.065)
        default: nil
        }
    }

    var alternatingPaneOffset: CGFloat {
        switch self {
        case .classic: 10
        default: 0
        }
    }

    var panePadding: CGFloat {
        switch self {
        case .classic: 12
        case .modern: 20
        }
    }

    var paneRowSpacing: CGFloat {
        switch self {
        case .classic: 4
        case .modern: 6
        }
    }

    var searchSpotlight: Bool {
        switch self {
        case .classic: true
        case .modern: false
        }
    }

    func titleFor(tile: Tile) -> String {
        if self == .modern {
            switch tile {
            case .general, .desktop, .dock: return localize("tile_\(tile.rawValue)_modern")
            default: return tile.title
            }
        }
        return tile.title
    }
}
