//
//  Extensions.swift
//  Settings Pal
//
//  Created by @gpoitch on 5/31/24.
//

import SwiftUI

extension Array {
    func split(into size: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, self.count)])
        }
    }

    func slice(from start: Int, to end: Int? = nil) -> Array {
        let endIndex = end ?? self.count
        let validStartIndex = Swift.max(0, Swift.min(start, self.count))
        let validEndIndex = Swift.max(0, Swift.min(endIndex, self.count))
        guard validStartIndex < validEndIndex else { return [] }
        return Array(self[validStartIndex..<validEndIndex])
    }
}

extension NSImage {
    func resized(to newSize: NSSize) -> NSImage? {
        let ratio = min(newSize.width / size.width, newSize.height / size.height)
        let scaledSize = NSSize(width: size.width * ratio, height: size.height * ratio)

        return NSImage(size: scaledSize, flipped: false) { _ in
            self.draw(in: NSRect(origin: .zero, size: scaledSize))
            return true
        }
    }
}

extension URL {
    func open() {
        NSWorkspace.shared.open(self)
    }
}

extension Locale {
    var isSpanish: Bool {
        identifier.starts(with: "es")
    }
}

extension View {
    func noAnimation() -> some View {
        return transaction {
            $0.disablesAnimations = true
            $0.animation = nil
        }
    }
}

func localize(_ key: String, tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "") -> String {
    let fallbackLanguage = "en"
    guard let fallbackBundlePath = Bundle.main.path(forResource: fallbackLanguage, ofType: "lproj") else { return key }
    guard let fallbackBundle = Bundle(path: fallbackBundlePath) else { return key }
    let fallbackString = fallbackBundle.localizedString(forKey: key, value: "", table: nil)
    return Bundle.main.localizedString(forKey: key, value: fallbackString, table: nil)
}

struct MaterialView: NSViewRepresentable {
    var material: NSVisualEffectView.Material = .windowBackground
    var blendingMode: NSVisualEffectView.BlendingMode = .behindWindow

    func makeNSView(context: Context) -> NSVisualEffectView {
        let effectView = NSVisualEffectView()
        effectView.material = material
        effectView.blendingMode = blendingMode
        effectView.state = .active
        return effectView
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) { }
}
