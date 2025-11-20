//
//  MHotelCardActions.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 20/11/25.
//

import SwiftUI

public struct MHotelCardActions: View {
    let onBook: () -> Void
    let onWishlist: () -> Void
    let onShare: () -> Void

    public init(
        onBook: @escaping () -> Void,
        onWishlist: @escaping () -> Void,
        onShare: @escaping () -> Void
    ) {
        self.onBook = onBook
        self.onWishlist = onWishlist
        self.onShare = onShare
    }

    public var body: some View {
        HStack(spacing: 10) {
            APrimaryButton(
                title: "Book Now",
                height: 35,
                isFullWidth: true,
                action: onBook
            )

            ACircleIconButton(
                iconName: "heart",
                size: .large,
                accessibilityLabel: "Add to wishlist",
                action: onWishlist
            )
            
            ACircleIconButton(
                iconName: "square.and.arrow.up",
                size: .large,
                accessibilityLabel: "Share hotel",
                action: onWishlist
            )
        }
    }
}
