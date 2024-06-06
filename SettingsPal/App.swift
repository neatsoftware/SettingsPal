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
            MainView().environmentObject(appState)
        }
        .windowResizability(.contentSize)
        .windowToolbarStyle(.unified)
        .commands {
            CommandGroup(replacing: .newItem) {}
            CommandGroup(after: .toolbar) {
                TileMenuItems().environmentObject(appState)
            }
        }

        Settings {
            SettingsView().environmentObject(appState)
        }
        .windowResizability(.contentSize)
        .windowToolbarStyle(.expanded)
    }
}

class SettingsPalAppDelegate: NSObject, NSApplicationDelegate {
    override init() {
        super.init()
        UserDefaults.standard.set(false, forKey: "NSFullScreenMenuItemEverywhere")
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSWindow.allowsAutomaticWindowTabbing = false
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    func applicationDockMenu(_ sender: NSApplication) -> NSMenu? {
        return TileMenu.asNSMenu(action: #selector(openSettings))
    }

    @objc private func openSettings(_ sender: NSMenuItem) {
        (sender.representedObject as? Tile)?.open()
    }
}
