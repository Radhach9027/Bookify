//
//  AShimmerPlaceRow.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 11/11/25.
//

import SwiftUI

public struct AShimmerPlaceRow: View {
    public init() {}
    public var body: some View {
        RoundedRectangle(cornerRadius: 18)
            .fill(Color.gray.opacity(0.15))
            .frame(height: 220)
    }
}
