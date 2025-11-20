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
            ForEach(0..<max, id: \.self) { i in
                Image(systemName: starFill(for: i))
                    .imageScale(.small)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [
                                Color.yellow,
                                Color.orange.opacity(0.9)
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
    
    private func starFill(for i: Int) -> String {
        let v = rating - Double(i)
        if v >= 1 { return "star.fill" }
        else if v >= 0.5 { return "star.leadinghalf.filled" }
        else { return "star" }
    }
}
