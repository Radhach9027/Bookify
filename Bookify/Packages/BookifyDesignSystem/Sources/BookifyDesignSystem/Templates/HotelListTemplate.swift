//
//  HotelListTemplate.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 14/11/25.
//

import SwiftUI

public struct HotelListTemplate: View {
    public let hotels: [HotelCardProps]
    public let onBook: (HotelCardProps) -> Void
    public let onWishlist: (HotelCardProps) -> Void
    public let onShare: (HotelCardProps) -> Void

    public init(
        hotels: [HotelCardProps],
        onBook: @escaping (HotelCardProps) -> Void = { _ in },
        onWishlist: @escaping (HotelCardProps) -> Void = { _ in },
        onShare: @escaping (HotelCardProps) -> Void = { _ in }
    ) {
        self.hotels = hotels
        self.onBook = onBook
        self.onWishlist = onWishlist
        self.onShare = onShare
    }

    public var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(hotels) { props in
                    HotelCard(
                        props: props,
                        onBook: { onBook(props) },
                        onWishlist: { onWishlist(props) },
                        onShare: {onShare(props)}
                    )
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
        }
    }
}

