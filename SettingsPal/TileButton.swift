//
//  TileButton.swift
//  Settings Pal
//
//  Created by @gpoitch on 6/3/24.
//

import SwiftUI

struct TileButton: View {
    let tile: Tile
    @Environment(\.locale) private var locale
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var appState: AppState
    @State private var isHoverEffectOn = false

    private var width: CGFloat {
        if locale.isSpanish { return 90 }
        return 78
    }

    var body: some View {
        let matchesSearch = appState.theme.titleFor(tile: tile).localizedCaseInsensitiveContains(appState.searchText)
        Button(action: { tile.open() }, label: {
            VStack(spacing: appState.theme.tileContentSpacing) {
                if appState.theme.useTileIcon {
                    Image(tile.icon).resizable().frame(width: 40, height: 40)
                } else {
                    ZStack {
                        tile.color
                        LinearGradient(colors: [.white.opacity(0.35), .white.opacity(0)], startPoint: .top, endPoint: .bottom)
                        Group {
                            if tile.customSymbol {
                                Image(tile.symbol).resizable().scaledToFit()
                            } else {
                                Image(systemName: tile.symbol)
                            }
                        }
                        .frame(maxWidth: 28, maxHeight: 28)
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(.white).shadow(color: .black.opacity(0.2), radius: 0.5, y: 0.5)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .shadow(color: .black.opacity(0.1), radius: isHoverEffectOn ? 4 : 1, y: 1)
                    .scaleEffect(isHoverEffectOn ? 1.05 : 1)
                    .offset(y: isHoverEffectOn ? -1 : 0)
                    .frame(width: 40, height: 40)
                }

                Text(appState.theme.titleFor(tile: tile))
                    .font(.callout).multilineTextAlignment(.center)
                    .allowsTightening(true)
                    .minimumScaleFactor(0.75)
                    .lineLimit(2)
                    .frame(maxHeight: .infinity, alignment: .top)
            }
            .padding(EdgeInsets(top: 6, leading: 0, bottom: 0, trailing: 0))
            .frame(width: width, height: 87)
            .contentShape(RoundedRectangle(cornerRadius: 6))
            .background {
                if appState.theme.searchSpotlight && matchesSearch {
                    Circle().fill(
                        RadialGradient(colors: [.white.opacity(0.8), .white.opacity(0)], center: .center, startRadius: 1, endRadius: 48).opacity(colorScheme == .dark ? 0.3 : 1)
                    ).padding(-12).offset(y: -8)
                }
            }
        })
        .buttonStyle(TileButtonStyle(normalBlendMode: !appState.theme.searchSpotlight || appState.searchText.isEmpty || matchesSearch))
        .opacity(!appState.theme.searchSpotlight && !appState.searchText.isEmpty && !matchesSearch ? 0.1 : 1)
        .onHover { hovering in
            if !appState.theme.tileHoverEffect { return }
            withAnimation(.easeOut(duration: 0.1)) {
                isHoverEffectOn = hovering
            }
        }
    }
}

private struct TileButtonStyle: ButtonStyle {
    let normalBlendMode: Bool
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var appState: AppState

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .blendMode(configuration.isPressed && appState.theme.tilePressedBlendMode ? (colorScheme == .dark ? .plusLighter : .plusDarker) : normalBlendMode ? .normal : (colorScheme == .dark ? .overlay : .multiply))
            .opacity(appState.theme.tilePressedBlendMode ? 1 : (configuration.isPressed ? 0.7 : 1))
            .foregroundStyle(configuration.isPressed ? appState.theme.tileTextColorPressed : appState.theme.tileTextColor)
    }
}

#Preview {
    TileButton(tile: .network)
}
