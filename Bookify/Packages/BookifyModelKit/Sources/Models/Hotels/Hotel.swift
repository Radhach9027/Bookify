//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public struct Hotel: Identifiable, Hashable, Codable, Sendable {
    public var id: HotelID
    public var name: String
    public var brand: String?
    public var description: String?
    public var address: Address
    public var locality: Locality?
    public var geo: Geo?
    public var timeZoneID: String?
    public var contact: ContactInfo?
    public var stars: Int?
    public var review: ReviewSummary?     // aggregate
    public var reviews: [Review]?
    public var amenitySet: Set<Amenity>
    public var amenitiesRaw: Set<String>    // for unknown/extra amenities
    public var facilities: Set<String>      // e.g., "parking", "gym"
    public var languages: Set<String>?      // ISO 639-1 codes
    public var images: [ImageAsset]
    public var rooms: [Room]                 // availability snapshot (for a given StayContext)
    public var policies: Policies?
    public var propertyType: PropertyType?
    public var availability: HotelAvailability?
    public var distanceMeters: Double?
    public var tags: [String]
    public var provider: ProviderRef?
    public var source: SourceMeta?
    public var createdAt: String?
    public var updatedAt: String?
    
    public init(
        id: HotelID,
        name: String,
        brand: String? = nil,
        description: String? = nil,
        address: Address,
        locality: Locality? = nil,
        geo: Geo? = nil,
        timeZoneID: String? = nil,
        contact: ContactInfo? = nil,
        stars: Int? = nil,
        review: ReviewSummary? = nil,
        reviews: [Review]? = nil,
        amenitySet: Set<Amenity> = [],
        amenitiesRaw: Set<String> = [],
        facilities: Set<String> = [],
        languages: Set<String>? = nil,
        images: [ImageAsset] = [],
        rooms: [Room] = [],
        policies: Policies? = nil,
        propertyType: PropertyType? = nil,
        availability: HotelAvailability? = nil,
        distanceMeters: Double? = nil,
        tags: [String] = [],
        provider: ProviderRef? = nil,
        source: SourceMeta? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil
    ) {
        self.id = id;
        self.name = name;
        self.brand = brand;
        self.description = description
        self.address = address;
        self.locality = locality;
        self.geo = geo;
        self.timeZoneID = timeZoneID
        self.contact = contact;
        self.stars = stars;
        self.review = review
        self.reviews = reviews
        self.amenitySet = amenitySet;
        self.amenitiesRaw = amenitiesRaw
        self.facilities = facilities;
        self.languages = languages
        self.images = images;
        self.rooms = rooms;
        self.policies = policies
        self.propertyType = propertyType;
        self.availability = availability
        self.distanceMeters = distanceMeters;
        self.tags = tags
        self.provider = provider;
        self.source = source
        self.createdAt = createdAt;
        self.updatedAt = updatedAt
    }
}
