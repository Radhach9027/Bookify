//
//  View+Extensions.swift
//  MyHotels
//
//  Created by radha chilamkurthy on 22/10/25.
//

import SwiftUI

public extension View {
    func shimmer() -> some View {
        self
            .overlay(
                LinearGradient(gradient: Gradient(colors: [.clear, .white.opacity(0.35), .clear]),
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                .blendMode(.plusLighter)
                .rotationEffect(.degrees(20))
                .offset(x: -200)
                .mask(self)
                .animation(.linear(duration: 1.2).repeatForever(autoreverses: false), value: UUID())
            )
    }
}

public extension View {
    func appTopBar(_ config: AppTopBarConfig) -> some View {
        modifier(AppTopBarModifier(config: config))
    }
    
    func appDetailTopBar(_ config: AppDetailTopBarConfig) -> some View {
        modifier(AppDetailTopBarModifier(config: config))
    }
}

