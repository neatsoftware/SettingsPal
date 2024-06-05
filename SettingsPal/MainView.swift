//
//  MainView.swift
//  Settings Pal
//
//  Created by @gpoitch on 5/28/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        VStack(spacing: 0) {
            UserPaneView()
            Divider()
            PaneView(tiles: [.general, .desktop, .dock, .missionControl, .siri, .spotlight, .language, .notifications, .internetAccounts, .passwords, .users, .accessibility, .screenTime, .extensions, .security])
                .padding(.bottom, -appState.theme.alternatingPaneOffset)
                .background(appState.theme.alternatingPaneBgColor)

            Divider()
            PaneView(tiles: [.softwareUpdate, .network, .bluetooth, .sound, .keyboard, .trackpad, .mouse, .displays, .printers, .battery, .dateTime, .sharing, .timeMachine, .startupDisk])
                .padding(.top, appState.theme.alternatingPaneOffset)
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigation) {
                Menu(localize("show_all"), systemImage: "square.grid.4x3.fill") {
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
                }.menuIndicator(.hidden).help(localize("show_all"))
            }

            ToolbarItem {
                Button("") {}.frame(width: 150).buttonStyle(.plain)
            }
        }
        .navigationTitle("Settings Pal")
        .fixedSize()
        .animation(.easeOut(duration: 0.12), value: appState.searchText)
        .searchable(text: $appState.searchText, placement: .toolbar)
        .background {
            ZStack {
                appState.theme.backgroundView
                if !appState.searchText.isEmpty && appState.theme.searchSpotlight {
                    Color.black.opacity(0.6)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                NSApp.keyWindow?.makeFirstResponder(nil)
            })
        }
    }
}

private struct UserPaneView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var appState: AppState

    var body: some View {
        HStack {
            HStack(spacing: 10) {
                let isSignedIn = appState.userName != nil

                let image = if let imageData = appState.userAvatar, let nsImage = NSImage(data: imageData) {
                    Image(nsImage: nsImage)
                } else {
                    Image(systemName: "person.crop.circle.fill")
                }

                image.resizable()
                    .frame(width: 64, height: 64).clipShape(Circle())
                    .foregroundStyle(.white, LinearGradient(colors: colorScheme == .dark ? [.init(white: 0.5), .init(white: 0.3)] : [.init(white: 0.7), .init(white: 0.5)], startPoint: .top, endPoint: .bottom))

                VStack(alignment: .leading, spacing: 2) {
                    Text(appState.userName ?? localize("signIn"))
                        .font(isSignedIn ? .system(size: 18) : .system(size: 13, weight: .bold))

                    Text(isSignedIn ? localize("appleId_desc") : localize("appleIdSignedOut_desc")).font(.system(size: 11))
                }
                .padding(.bottom, 14)

                if appState.contactsStatus != .authorized {
                    Button {
                        if appState.contactsStatus == .notDetermined {
                            appState.fetchMeContactWithAccessRequest()
                        } else {
                            Tile.security.open("?Privacy_Contacts")
                        }
                    } label: {
                        Group {
                            if appState.contactsStatus == .notDetermined {
                                Image(systemName: "person.badge.shield.checkmark.fill").foregroundStyle(.white)
                                    .padding(6)
                                    .background(Color.green)
                            } else {
                                Image(systemName: "arrow.up.right.circle.fill")
                                    .foregroundStyle(.white, .orange)
                            }
                        }
                        .font(.system(size: 16, weight: .bold))
                        .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                    .help("Grant access to Contacts to display your user info")
                }
            }
            .blendMode((appState.searchText.isEmpty || !appState.theme.searchSpotlight) ? .normal : colorScheme == .dark ? .overlay : .multiply)
            Spacer()
            PaneRowsView(tiles: [.appleId, .familySharing])
        }
        .padding(EdgeInsets(top: appState.theme.panePadding, leading: appState.theme.panePadding + 13, bottom: appState.theme.panePadding, trailing: appState.theme.panePadding))
        .background(appState.theme.userPaneBgView)
    }
}

private struct PaneView: View {
    let tiles: [Tile]
    @EnvironmentObject private var appState: AppState

    var body: some View {
        PaneRowsView(tiles: tiles)
            .padding(appState.theme.panePadding)
            .frame(maxWidth: .infinity)
    }
}

private struct PaneRowsView: View {
    let tiles: [Tile]
    @Environment(\.locale) private var locale
    @EnvironmentObject private var appState: AppState

    var body: some View {
        VStack(alignment: .leading, spacing: appState.theme.paneRowSpacing) {
            ForEach(tiles.split(into: 8), id: \.self) { group in
                HStack(spacing: appState.theme.tileColumnSpacing - (locale.isSpanish ? 1 : 0)) {
                    ForEach(group) { info in
                        TileButton(tile: info)
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}
