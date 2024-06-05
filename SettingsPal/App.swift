//
//  SettingsPalApp.swift
//  Settings Pal
//
//  Created by @gpoitch on 5/28/24.
//

import SwiftUI

@main
struct SettingsPalApp: App {
    @NSApplicationDelegateAdaptor(SettingsPalAppDelegate.self) private var appDelegate

    var body: some Scene {
        SettingsPalMainScene()
    }
}

struct SettingsPalMainScene: Scene {
    private let appState = AppState()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(appState)
        }
        .windowResizability(.contentSize)
        .windowToolbarStyle(.unified(showsTitle: true))

        Settings {
            SettingsView()
                .environmentObject(appState)
        }
        .windowResizability(.contentSize)
        .windowToolbarStyle(.expanded)
    }
}

class SettingsPalAppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    func applicationDockMenu(_ sender: NSApplication) -> NSMenu? {
        let menu = NSMenu()
        menu.items = Tile.allCasesSorted.map({
            let item = NSMenuItem(title: $0.title, action: #selector(openSettings), keyEquivalent: "")
            item.representedObject = $0
            return item
        })
        return menu
    }

    @objc private func openSettings(_ sender: NSMenuItem) {
        (sender.representedObject as? Tile)?.open()
    }
}
