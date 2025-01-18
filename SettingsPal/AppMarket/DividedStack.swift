//
//  DividedStack.swift
//
//  Created by garth on 8/15/24.
//  Copyright © 2024 Neat Software Co. All rights reserved.
//

import SwiftUI

/// A vertical stack view that automatically places dividers between its children
public struct DividedVStack<Content: View>: View {
    private let alignment: HorizontalAlignment?
    private let spacing: CGFloat?
    private let dividerOpacity: Double?
    private let content: () -> Content

    /// Creates a new divided vertical stack view
    /// - Parameters:
    ///   - alignment: The horizontal alignment to use for the stack. If nil, uses the system default
    ///   - spacing: The spacing between views in the stack. If nil, uses the system default
    ///   - dividerOpacity: The opacity of dividers between views. If nil, uses fully opaque dividers
    ///   - content: A closure that creates the stack's content
    public init(
        alignment: HorizontalAlignment? = nil,
        spacing: CGFloat? = nil,
        dividerOpacity: Double? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.dividerOpacity = dividerOpacity
        self.content = content
    }

    public var body: some View {
        _VariadicView.Tree(
            DividedVStackLayout(
                alignment: alignment,
                spacing: spacing,
                dividerOpacity: dividerOpacity
            ),
            content: content
        )
    }
}

/// A horizontal stack view that automatically places dividers between its children
public struct DividedHStack<Content: View>: View {
    private let alignment: VerticalAlignment?
    private let spacing: CGFloat?
    private let dividerOpacity: Double?
    private let content: () -> Content

    /// Creates a new divided horizontal stack view
    /// - Parameters:
    ///   - alignment: The vertical alignment to use for the stack. If nil, uses the system default
    ///   - spacing: The spacing between views in the stack. If nil, uses the system default
    ///   - dividerOpacity: The opacity of dividers between views. If nil, uses fully opaque dividers
    ///   - content: A closure that creates the stack's content
    public init(
        alignment: VerticalAlignment? = nil,
        spacing: CGFloat? = nil,
        dividerOpacity: Double? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.dividerOpacity = dividerOpacity
        self.content = content
    }

    public var body: some View {
        _VariadicView.Tree(
            DividedHStackLayout(
                alignment: alignment,
                spacing: spacing,
                dividerOpacity: dividerOpacity
            ),
            content: content
        )
    }
}

private let DefaultSpacing: CGFloat = 8

private struct DividedVStackLayout: _VariadicView_UnaryViewRoot {
    var alignment: HorizontalAlignment?
    var spacing: CGFloat?
    var dividerOpacity: Double?

    @ViewBuilder func body(children: _VariadicView.Children) -> some View {
        let last = children.last?.id
        VStack(alignment: alignment ?? .leading, spacing: spacing ?? DefaultSpacing) {
            ForEach(children) { child in
                child
                if child.id != last {
                    Divider().opacity(dividerOpacity ?? 1)
                }
            }
        }
    }
}

private struct DividedHStackLayout: _VariadicView_UnaryViewRoot {
    var alignment: VerticalAlignment?
    var spacing: CGFloat?
    var dividerOpacity: Double?

    @ViewBuilder func body(children: _VariadicView.Children) -> some View {
        let last = children.last?.id
        HStack(alignment: alignment ?? .center, spacing: spacing ?? DefaultSpacing) {
            ForEach(children) { child in
                child
                if child.id != last {
                    Divider().opacity(dividerOpacity ?? 1).frame(width: 1)
                }
            }
        }
    }
}
