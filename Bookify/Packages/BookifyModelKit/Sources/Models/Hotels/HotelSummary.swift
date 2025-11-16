//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public struct HotelSummary: Identifiable, Hashable, Codable, Sendable {
    public var id: HotelID
    public var name: String
    public var city: String?
    public var rating: Double?
    public var stars: Int?
    public var leadPrice: Money?      // cheapest rate for the stay context
    public var thumbnail: ImageAsset?
    public var distanceMeters: Double?
    public init(
        id: HotelID,
        name: String,
        city: String? = nil,
        rating: Double? = nil,
        stars: Int? = nil,
        leadPrice: Money? = nil,
        thumbnail: ImageAsset? = nil,
        distanceMeters: Double? = nil
    ) {
        self.id = id;
        self.name = name;
        self.city = city;
        self.rating = rating
        self.stars = stars;
        self.leadPrice = leadPrice;
        self.thumbnail = thumbnail
        self.distanceMeters = distanceMeters
    }
}
