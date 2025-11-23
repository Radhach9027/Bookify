//
//  ALoadingView.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 22/11/25.
//

import SwiftUI

public struct ALoadingView: View {
    public enum Style {
        case centered
        case tinted(Color)
    }
    
    private let style: Style
    private let message: String?
    
    public init(
        style: Style = .centered,
        message: String? = nil
    ) {
        self.style = style
        self.message = message
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            progress
            
            if let message {
                Text(message)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(message ?? "Loading")
    }
    
    @ViewBuilder
    private var progress: some View {
        switch style {
        case .centered:
            ProgressView()
        case .tinted(let color):
            ProgressView()
                .tint(color)
        }
    }
}

