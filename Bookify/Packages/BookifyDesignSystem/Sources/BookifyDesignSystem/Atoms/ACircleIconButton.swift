//
//  ACircleIconButton.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 20/11/25.
//

import SwiftUI

public struct ACircleIconButton: View {
    public enum Size {
        case small
        case medium
        case large

        var dimension: CGFloat {
            switch self {
            case .small:  return 32
            case .medium: return 40
            case .large:  return 48
            }
        }
    }

    let iconName: String
    let size: Size
    let accessibilityLabel: String?
    let action: () -> Void

    public init(
        iconName: String,
        size: Size = .medium,
        accessibilityLabel: String? = nil,
        action: @escaping () -> Void
    ) {
        self.iconName = iconName
        self.size = size
        self.accessibilityLabel = accessibilityLabel
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color(.systemBackground))
                AIcon(iconName, size: .medium)
            }
            .frame(width: size.dimension, height: size.dimension)
        }
        .buttonStyle(.borderless)
        .accessibilityLabel(accessibilityLabel ?? iconName)
    }
}

