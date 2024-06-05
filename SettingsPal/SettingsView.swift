//
//  SettingsView.swift
//  Settings Pal
//
//  Created by @gpoitch on 6/3/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        TabView {
            VStack {
                GroupBox {
                    HStack {
                        Text("Style").fontWeight(.medium)
                        Spacer()
                        Picker("Style", selection: $appState.theme.animation(.easeOut(duration: 0.2))) {
                            ForEach(Theme.allCases, id: \.self) {
                                Text($0.title)
                            }
                        }.labelsHidden().fixedSize()
                    }.padding(12)
                }
            }
            .padding(20)
            .tabItem {
                Label("General", systemImage: "gearshape")
            }
        }
        .navigationTitle("Settings")
        .frame(width: 430)
    }
}

#Preview {
    SettingsView()
}
