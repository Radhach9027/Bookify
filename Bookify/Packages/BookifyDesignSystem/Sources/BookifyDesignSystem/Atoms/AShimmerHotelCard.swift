//
//  AShimmerHotelCard.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 11/11/25.
//

import SwiftUI

public struct AShimmerHotelCard: View {
    public init() {}
    public var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.gray.opacity(0.15))
            .frame(width: 270, height: 200)
    }
}
