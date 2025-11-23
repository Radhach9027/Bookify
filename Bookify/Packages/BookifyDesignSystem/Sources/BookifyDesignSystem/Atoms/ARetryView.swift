//
//  ARetryView.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 22/11/25.
//

import SwiftUI

public struct ARetryView: View {
    public let title: String
    public let buttonTitle: String
    public let onRetry: () -> Void

    public init(
        title: String,
        buttonTitle: String = "Retry",
        onRetry: @escaping () -> Void
    ) {
        self.title = title
        self.buttonTitle = buttonTitle
        self.onRetry = onRetry
    }

    public var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.subheadline.weight(.semibold))

            Button(buttonTitle, action: onRetry)
                .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

