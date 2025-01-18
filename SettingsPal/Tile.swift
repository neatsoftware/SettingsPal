//
//  Tile.swift
//  Settings Pal
//
//  Created by @gpoitch on 5/28/24.
//

import SwiftUI

enum Tile: String, Identifiable, CaseIterable {
    var id: String {
        return rawValue
    }

    case appleId, familySharing,

         general, desktop, dock, missionControl, siri, spotlight, language, notifications,
         internetAccounts, passwords, users, accessibility, screenTime, extensions, security,

         softwareUpdate, network, bluetooth, sound, keyboard, trackpad, mouse, displays,
         printers, battery, dateTime, sharing, timeMachine, startupDisk

    var title: String {
        return localize("tile_\(rawValue)")
    }

    var icon: String {
        return rawValue
    }

    func open(_ query: String = "") {
        if let url = URL(string: "x-apple.systempreferences:com.apple.\(extensionPath)\(query)") {
            NSWorkspace.shared.open(url)
        }
    }

    static var allCasesSorted: [Tile] {
        return allCases.sorted(by: { $0.title < $1.title })
    }

    // https://github.com/bvanpeski/SystemPreferences/blob/main/macos_preferencepanes-Ventura.md
    private var extensionPath: String {
        switch self {
        case .appleId: "systempreferences.AppleIDSettings"
        case .familySharing: "Family-Settings.extension"
        case .general: "Appearance-Settings.extension"
        case .desktop: "Wallpaper-Settings.extension"
        case .dock: "Desktop-Settings.extension"
        case .missionControl: "Desktop-Settings.extension?MissionControl"
        case .siri: "Siri-Settings.extension"
        case .spotlight: "Spotlight-Settings.extension"
        case .language: "Localization-Settings.extension"
        case .notifications: "Notifications-Settings.extension"
        case .internetAccounts: "Internet-Accounts-Settings.extension"
        case .passwords: "Passwords-Settings.extension"
        case .users: "Users-Groups-Settings.extension"
        case .accessibility: "Accessibility-Settings.extension"
        case .screenTime: "Screen-Time-Settings.extension"
        case .extensions: "ExtensionsPreferences"
        case .security: "settings.PrivacySecurity.extension"
        case .softwareUpdate: "Software-Update-Settings.extension"
        case .network: "Network-Settings.extension"
        case .bluetooth: "BluetoothSettings"
        case .sound: "Sound-Settings.extension"
        case .printers: "Print-Scan-Settings.extension"
        case .keyboard: "Keyboard-Settings.extension"
        case .trackpad: "Trackpad-Settings.extension"
        case .mouse: "Mouse-Settings.extension"
        case .displays: "Displays-Settings.extension"
        case .battery: "Battery-Settings.extension"
        case .dateTime: "Date-Time-Settings.extension"
        case .sharing: "Sharing-Settings.extension"
        case .timeMachine: "Time-Machine-Settings.extension"
        case .startupDisk: "Startup-Disk-Settings.extension"
        }
    }

    var color: Color {
        switch self {
        case .appleId: .cyan
        case .familySharing: .mint
        case .general: .black
        case .desktop: .cyan
        case .dock: .black
        case .missionControl: .purple
        case .siri: .pink
        case .spotlight: .orange
        case .language: .blue
        case .notifications: .red
        case .internetAccounts: .blue
        case .passwords: .gray
        case .users: .blue
        case .accessibility: .blue
        case .screenTime: .indigo
        case .extensions: .gray
        case .security: .blue
        case .softwareUpdate: .gray
        case .network: .blue
        case .bluetooth: .blue
        case .sound: .pink
        case .keyboard: .gray
        case .trackpad: .gray
        case .mouse: .gray
        case .displays: .blue
        case .printers: .gray
        case .battery: .green
        case .dateTime: .blue
        case .sharing: .gray
        case .timeMachine: .teal
        case .startupDisk: .gray
        }
    }

    var symbol: String {
        switch self {
        case .appleId: "apple.logo"
        case .familySharing: "figure.2.and.child.holdinghands"
        case .general: "circle.lefthalf.filled"
        case .desktop: "desktopcomputer"
        case .dock: "menubar.dock.rectangle"
        case .missionControl: "uiwindow.split.2x1"
        case .siri: "mic.fill"
        case .spotlight: "magnifyingglass"
        case .language: "globe"
        case .notifications: "bell.badge.fill"
        case .internetAccounts: "at"
        case .passwords: "key.fill"
        case .users: "person.2.fill"
        case .accessibility: "figure.child.circle"
        case .screenTime: "hourglass"
        case .extensions: "puzzlepiece.extension.fill"
        case .security: "hand.raised.fill"
        case .softwareUpdate: "gear.badge"
        case .network: "network"
        case .bluetooth: "logo.bluetooth"
        case .sound: "speaker.wave.3.fill"
        case .keyboard: "keyboard.fill"
        case .trackpad: "rectangle.and.hand.point.up.left.fill"
        case .mouse: "magicmouse.fill"
        case .displays: "sun.max.fill"
        case .printers: "printer.fill"
        case .battery: "battery.100percent"
        case .dateTime: "calendar.badge.clock"
        case .sharing: "figure.walk.diamond.fill"
        case .timeMachine: "clock.arrow.circlepath"
        case .startupDisk: "internaldrive.fill"
        }
    }

    var customSymbol: Bool {
        switch self {
        case .bluetooth: true
        default: false
        }
    }
}
