//
//  Place.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 10/11/25.
//

import Foundation
import CoreLocation

public struct Place: Identifiable, Equatable {
    public let id: String
    public let name: String
    public let category: String
    public let coordinate: CLLocationCoordinate2D
    public let imageURL: URL?
    public let rating: Double
    public let reviewsCount: Int
    public let summary: String
    
    public init(
        id: String,
        name: String,
        category: String,
        coordinate: CLLocationCoordinate2D,
        imageURL: URL?,
        rating: Double,
        reviewsCount: Int,
        summary: String
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.coordinate = coordinate
        self.imageURL = imageURL
        self.rating = rating
        self.reviewsCount = reviewsCount
        self.summary = summary
    }
}

extension Place {
    public var clLocation: CLLocation {
        CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}

extension Place {
    public static func == (lhs: Place, rhs: Place) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.category == rhs.category &&
        lhs.coordinate.latitude == rhs.coordinate.latitude &&
        lhs.coordinate.longitude == rhs.coordinate.longitude &&
        lhs.imageURL == rhs.imageURL &&
        lhs.rating == rhs.rating &&
        lhs.reviewsCount == rhs.reviewsCount &&
        lhs.summary == rhs.summary
    }
}
