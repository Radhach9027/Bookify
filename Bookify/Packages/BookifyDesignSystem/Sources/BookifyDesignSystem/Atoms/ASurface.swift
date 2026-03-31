//
//  ASurface.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 11/11/25.
//

import SwiftUI

public struct ASurface: View {
    let corner: CGFloat
    let backgroundColor: Color
    let stroke: Color
    let content: AnyView

    public init(
        corner: CGFloat = 14,
        backgroundColor: Color = Color(.secondarySystemBackground),
        stroke: Color = Color.primary.opacity(0.06),
        @ViewBuilder content: () -> some View
    ) {
        self.corner = corner
        self.backgroundColor = backgroundColor
        self.stroke = stroke
        self.content = AnyView(content())
    }

    public var body: some View {
        content
            .padding(12)
            .background(RoundedRectangle(cornerRadius: corner, style: .continuous).fill(backgroundColor))
            .overlay(RoundedRectangle(cornerRadius: corner, style: .continuous).strokeBorder(stroke))
            .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
    }
}
