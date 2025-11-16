//
//  ALocationPill.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 14/11/25.
//

import SwiftUI

public struct ALocationPill: View {
    let locationImage: String
    let locationName: String

    public init(locationImage: String, locationName: String) {
        self.locationImage = locationImage
        self.locationName = locationName
    }

    public var body: some View {
        VStack(spacing: 2) {
            Image(systemName: locationImage)
                .font(.system(size: 12, weight: .semibold))
            Text(locationName)
                .font(.subheadline.weight(.semibold))
                .lineLimit(1)
                .truncationMode(.tail)
                .fixedSize(horizontal: true, vertical: false)
                .padding(.leading, 8)
                .padding(.trailing, 8)
                .padding(.bottom, 4)
        }
    }
}



