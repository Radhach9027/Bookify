//
//  APrimaryButton.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 20/11/25.
//

import SwiftUI

public struct APrimaryButton: View {
    let title: String
    let height: CGFloat
    let isFullWidth: Bool
    let font: Font
    let action: () -> Void

    public init(
        title: String,
        height: CGFloat = 44,
        isFullWidth: Bool = true,
        font: Font = .subheadline.weight(.semibold),
        action: @escaping () -> Void
    ) {
        self.title = title
        self.height = height
        self.isFullWidth = isFullWidth
        self.font = font
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(font)
                .frame(
                    maxWidth: isFullWidth ? .infinity : nil,
                    minHeight: height,
                    maxHeight: height
                )
        }
        .buttonStyle(.borderedProminent)
    }
}



