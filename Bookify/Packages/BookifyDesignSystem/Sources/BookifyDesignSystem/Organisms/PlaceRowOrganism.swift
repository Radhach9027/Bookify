//
//  PlaceRowOrganism.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 11/11/25.
//

import SwiftUI

public struct PlaceRowProps: Identifiable, Equatable {
    public var id: String
    public var name: String
    public var categoryText: String
    public var ratingValue: Double
    public var reviewsCountText: String
    public var distanceText: String
    public var summary: String
    public var image: () -> AAsyncImage

    public static func == (lhs: PlaceRowProps, rhs: PlaceRowProps) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.categoryText == rhs.categoryText &&
        lhs.ratingValue == rhs.ratingValue &&
        lhs.reviewsCountText == rhs.reviewsCountText &&
        lhs.distanceText == rhs.distanceText &&
        lhs.summary == rhs.summary
    }
}

public struct PlaceRowOrganism: View {
    let props: PlaceRowProps
    let onDirections: () -> Void
    let onBook: () -> Void
    
    public init(
        props: PlaceRowProps,
        onDirections: @escaping () -> Void,
        onBook: @escaping () -> Void)
    {
        self.props = props;
        self.onDirections = onDirections;
        self.onBook = onBook
    }
    
    public var body: some View {
        ASurface(corner: 18) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .firstTextBaseline) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(props.name).font(.headline).lineLimit(1)
                        HStack(spacing: 6) {
                            Label(props.categoryText, systemImage: "mappin.and.ellipse").labelStyle(.titleAndIcon).font(.caption).foregroundStyle(.secondary)
                            Text("•").foregroundStyle(.secondary)
                            ARatingStars(rating: props.ratingValue, max: 5, reviewsCountText: props.reviewsCountText)
                            Text(props.reviewsCountText).font(.caption).foregroundStyle(.secondary)
                        }
                    }
                    Spacer()
                    HStack(spacing: 4) { AIcon("location.circle"); Text(props.distanceText).font(.subheadline.weight(.semibold)) }
                        .accessibilityLabel("Distance \(props.distanceText)")
                }
                props.image()
                    .frame(height: 140).clipped().clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                Text(props.summary).font(.subheadline).foregroundStyle(.secondary).lineLimit(2)
                HStack(spacing: 10) {
                    Button(action: onDirections) {
                        Label(
                            "Directions",
                            systemImage: "arrow.triangle.turn.up.right.circle.fill")
                        .font(.subheadline.weight(.semibold))
                    }.buttonStyle(.bordered)
                    
                    Button(action: onBook) {
                        Text("Book Now")
                            .font(.subheadline.weight(.semibold))
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

