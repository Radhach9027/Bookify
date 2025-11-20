//
//  AText.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 11/11/25.
//

import SwiftUI

public struct AText: View {
    
    public enum Style {
        case title3Bold, headline, subheadline, caption, body
    }
    
    let text: String
    let style: Style
    let color: Color?
    
    public init(_ text: String, style: Style, color: Color? = nil) {
        self.text = text;
        self.style = style;
        self.color = color
    }
    
    public var body: some View {
        Text(text)
            .font(font)
            .foregroundStyle(color ?? .primary)
    }
    
    private var font: Font {
        switch style {
        case .title3Bold: return .title3.bold()
        case .headline: return .headline
        case .subheadline: return .subheadline
        case .caption: return .caption
        case .body: return .body
        }
    }
}
