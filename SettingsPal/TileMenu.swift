//
//  TileMenu.swift
//  Settings Pal
//
//  Created by @gpoitch on 6/5/24.
//

import SwiftUI

struct TileMenu: View {
    var body: some View {
        Menu(localize("show_all"), systemImage: "square.grid.4x3.fill") {
            TileMenuItems()
        }.menuIndicator(.hidden).help(localize("show_all"))
    }
}

struct TileMenuItems: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        ForEach(Tile.allCasesSorted) { tile in
            Button(action: { tile.open() }, label: {
                if appState.theme.useTileIcon {
                    Image(nsImage: NSImage(named: tile.icon)?.resized(to: NSSize(width: 18, height: 18)) ?? NSImage())
                } else {
                    if tile.customSymbol {
                        Image(nsImage: NSImage(named: tile.symbol)?.resized(to: NSSize(width: 18, height: 18)) ?? NSImage())
                    } else {
                        Image(systemName: tile.symbol)
                    }
                }
                Text(appState.theme.titleFor(tile: tile))
            })
        }
    }
}

extension TileMenu {
    static func asNSMenu(action: Selector) -> NSMenu {
        let menu = NSMenu()
        menu.items = Tile.allCasesSorted.map({
            let item = NSMenuItem(title: $0.title, action: action, keyEquivalent: "")
            item.representedObject = $0
            return item
        })
        return menu
    }
}
