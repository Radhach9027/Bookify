//
//  AChip.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 11/11/25.
//

import SwiftUI

public struct AChip: View {
    public struct Props: Equatable { let title: String; let selected: Bool }
    let props: Props; let onTap: () -> Void
    
    public init(_ props: Props, onTap: @escaping () -> Void) {
        self.props = props;
        self.onTap = onTap
    }
    
    public var body: some View {
        Button(action: onTap) {
            Text(props.title).font(.subheadline.weight(.semibold))
                .padding(.vertical, 8).padding(.horizontal, 14)
                .background(Capsule().fill(props.selected ? Color.blue.opacity(0.15) : Color.gray.opacity(0.1)))
                .overlay(Capsule().stroke(props.selected ? Color.blue : Color.gray.opacity(0.25), lineWidth: 1))
        }.buttonStyle(.plain)
    }
}
