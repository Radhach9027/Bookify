//
//  MPriceBlock.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 11/11/25.
//

import SwiftUI

public struct MPriceBlock: View {
    let priceText: String
    
    public init(priceText: String) {
        self.priceText = priceText
    }
    
    public var body: some View {
        VStack(alignment: .trailing, spacing: 2) {
            AText(priceText, style: .subheadline, color: .primary).font(.caption)
            AText("per night", style: .caption, color: .secondary)
        }
    }
}

