//
//  MPriceBlock.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 11/11/25.
//

import SwiftUI

public struct MPriceBlock: View {
    let priceText: String
    let originalPriceText: String?

    public init(
        priceText: String,
        originalPriceText: String? = nil
    ) {
        self.priceText = priceText
        self.originalPriceText = originalPriceText
    }

    public var body: some View {
        VStack(alignment: .trailing, spacing: 2) {
            if let original = originalPriceText {
                VStack(spacing: 4) {
                    if #available(iOS 16.0, *) {
                        AText(original, style: .title3Bold, color: .secondary)
                            .strikethrough(true, color: .secondary)
                    } else {
                        // MARK: TODO
                    }
                    AText(priceText, style: .title3Bold, color: .primary)
                }
            } else {
                AText(priceText, style: .body, color: .primary)
            }
            AText("per night", style: .caption, color: .secondary)
        }
    }
}


