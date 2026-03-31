//
//  ARatingStars.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 11/11/25.
//

import SwiftUI

public struct ARatingStars: View {
    let rating: Double
    let max: Int
    let reviewsCountText: String

    public var body: some View {
        HStack(spacing: 2) {
            ForEach(0 ..< max, id: \.self) { index in
                Image(systemName: starFill(for: index))
                    .imageScale(.small)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [
                                Color.yellow,
                                Color.orange.opacity(0.9),
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            }
            Text(String(format: "%.1f", rating))
                .fontWeight(.bold)
                .padding(.leading, 4)
            Text(reviewsCountText)
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.leading, 4)
        }
    }

    private func starFill(for fill: Int) -> String {
        let value = rating - Double(fill)
        if value >= 1 { return "star.fill" }
        else if value >= 0.5 { return "star.leadinghalf.filled" }
        else { return "star" }
    }
}
