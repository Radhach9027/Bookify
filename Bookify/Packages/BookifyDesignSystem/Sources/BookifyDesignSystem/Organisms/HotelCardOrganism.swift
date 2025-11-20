//
//  HotelCardOrganism.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 11/11/25.
//

import SwiftUI

public struct HotelCardProps: Identifiable, Equatable {
    public var id: String
    public var name: String
    public var city: String
    public var ratingText: String
    public var ratingValue: Double
    public var reviewsCountText: String
    public var priceText: String
    public var description: String
    public var imageUrl: URL
    
    public init(
        id: String,
        name: String,
        city: String,
        ratingText: String,
        ratingValue: Double,
        reviewsCountText: String,
        priceText: String,
        description: String,
        imageUrl: URL
    ) {
        self.id = id;
        self.name = name;
        self.city = city;
        self.ratingText = ratingText;
        self.ratingValue = ratingValue;
        self.reviewsCountText = reviewsCountText;
        self.priceText = priceText;
        self.description = description;
        self.imageUrl = imageUrl
    }
    
    public static func == (lhs: HotelCardProps, rhs: HotelCardProps) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.city == rhs.city &&
        lhs.ratingText == rhs.ratingText &&
        lhs.ratingValue == rhs.ratingValue &&
        lhs.reviewsCountText == rhs.reviewsCountText &&
        lhs.priceText == rhs.priceText &&
        lhs.description == rhs.description &&
        lhs.imageUrl == rhs.imageUrl
    }
}

public struct HotelCard: View {
    let props: HotelCardProps
    let onBook: () -> Void
    let onWishlist: () -> Void
    let onShare: () -> Void
    let width: CGFloat?

    public init(
        props: HotelCardProps,
        width: CGFloat? = nil,
        onBook: @escaping () -> Void,
        onWishlist: @escaping () -> Void,
        onShare: @escaping () -> Void
    ) {
        self.props = props
        self.width = width
        self.onBook = onBook
        self.onWishlist = onWishlist
        self.onShare = onShare
    }
    
    public var body: some View {
        let cardShape = RoundedRectangle(cornerRadius: 18, style: .continuous)

        VStack(spacing: 0) {
            ZStack(alignment: .bottomLeading) {
                AAsyncImage(url: props.imageUrl)
                    .frame(height: 130)
                    .clipped()
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.black.opacity(0.0),
                                Color.black.opacity(0.45)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .accessibilityLabel(Text(props.name))

                VStack(alignment: .leading, spacing: 4) {
                    Text(props.name)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .shadow(radius: 2)

                    HStack(spacing: 6) {
                        AIcon("mappin.and.ellipse", size: .small)
                        Text(props.city)
                    }
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.9))
                }
                .padding(12)
            }

            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 8) {
                    ARatingStars(
                        rating: props.ratingValue,
                        max: 5,
                        reviewsCountText: props.reviewsCountText
                    )
                    Spacer()
                    MPriceBlock(priceText: props.priceText)
                }

                Text(props.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                MHotelCardActions(
                    onBook: onBook,
                    onWishlist: onWishlist,
                    onShare: onShare
                )
            }
            .padding(14)
        }
        .modifier(CardWidth(width: width))
        .background(Color(.secondarySystemBackground))
        .clipShape(cardShape)
        .overlay(cardShape.strokeBorder(Color.primary.opacity(0.06)))
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
        .accessibilityElement(children: .combine)
    }
}

private struct CardWidth: ViewModifier {
    let width: CGFloat?
    func body(content: Content) -> some View {
        if let width {
            content.frame(width: width)
        } else {
            content.frame(maxWidth: .infinity)
        }
    }
}

