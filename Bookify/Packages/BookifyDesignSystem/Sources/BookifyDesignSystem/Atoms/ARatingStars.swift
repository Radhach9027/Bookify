//
//  ARatingStars.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 11/11/25.
//

import SwiftUI

public struct ARatingStars: View {
    let rating: Double; let max: Int
    
    public init(rating: Double, max: Int = 5) {
        self.rating = rating;
        self.max = max
    }
    
    public var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<max, id: \.self) { i in
                Image(systemName: starFill(for: i)).imageScale(.small)
            }
            Text(String(format: "%.1f", rating)).font(.caption).padding(.leading, 4)
        }
    }
    private func starFill(for i: Int) -> String {
        let v = rating - Double(i)
        if v >= 1 { return "star.fill" }
        else if v >= 0.5 { return "star.leadinghalf.filled" }
        else { return "star" }
    }
}
