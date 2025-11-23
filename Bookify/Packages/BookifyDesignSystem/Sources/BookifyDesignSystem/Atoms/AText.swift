//
//  AText.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 11/11/25.
//

import SwiftUI

public struct AText: View {

    public enum ATypographyStyle {
        case title3Bold, headline, subheadline, body, caption, caption2, footnote

        var font: Font {
            switch self {
            case .title3Bold:  return .title3.weight(.bold)
            case .headline:    return .headline
            case .subheadline: return .subheadline
            case .body:        return .body
            case .caption:     return .caption
            case .caption2:    return .caption2
            case .footnote:    return .footnote
            }
        }
    }

    private let text: String
    private let style: ATypographyStyle
    private let color: Color
    private let alignment: TextAlignment
    private let lineLimit: Int?
    private let minScale: CGFloat
    private let isUppercased: Bool
    private let kerningValue: CGFloat
    private let underlineEnabled: Bool
    private let strikeEnabled: Bool
    private let monospacedDigits: Bool
    private let italicEnabled: Bool

    public init(
        _ text: String,
        style: ATypographyStyle = .body,
        color: Color = .primary,
        alignment: TextAlignment = .leading,
        lineLimit: Int? = nil,
        minScale: CGFloat = 1.0,
        isUppercased: Bool = false,
        kerning: CGFloat = 0,
        underline: Bool = false,
        strikeThrough: Bool = false,
        monospacedDigits: Bool = false,
        italic: Bool = false
    ) {
        self.text = text
        self.style = style
        self.color = color
        self.alignment = alignment
        self.lineLimit = lineLimit
        self.minScale = minScale
        self.isUppercased = isUppercased
        self.kerningValue = kerning
        self.underlineEnabled = underline
        self.strikeEnabled = strikeThrough
        self.monospacedDigits = monospacedDigits
        self.italicEnabled = italic
    }

    public var body: some View {
        baseText
            .foregroundColor(color)
            .multilineTextAlignment(alignment)
            .lineLimit(lineLimit)
            .minimumScaleFactor(minScale)
            .modifier(AMonospacedDigits(enabled: monospacedDigits))
            .modifier(AItalic(enabled: italicEnabled))
    }

    private var baseText: Text {
        var t = Text(isUppercased ? text.uppercased() : text)

        // iOS 13–15 SAFE calls:
        t = t.font(style.font)
        t = t.kerning(kerningValue)                  // iOS 13 safe
        t = t.underline(underlineEnabled)            // iOS 13 safe
        t = t.strikethrough(strikeEnabled)           // iOS 13 safe

        return t
    }
}

// MARK: - Monospaced Digits (iOS 13 safe)
private struct AMonospacedDigits: ViewModifier {
    let enabled: Bool
    func body(content: Content) -> some View {
        enabled ? AnyView(content.monospacedDigit()) : AnyView(content)
    }
}

// MARK: - Italic (iOS 13 safe)
private struct AItalic: ViewModifier {
    let enabled: Bool

    func body(content: Content) -> some View {
        guard enabled else { return AnyView(content) }

        // Force italic using fontDescriptor instead of .italic()
        let italicFont = UIFont.systemFont(ofSize: UIFont.labelFontSize).withTraits(.traitItalic)
        return AnyView(content.font(Font(italicFont)))
    }
}


extension UIFont {
    func withTraits(_ traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard let descriptor = fontDescriptor.withSymbolicTraits(traits) else { return self }
        return UIFont(descriptor: descriptor, size: 0)
    }
}
