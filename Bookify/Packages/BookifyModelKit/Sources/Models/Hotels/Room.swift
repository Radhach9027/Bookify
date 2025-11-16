//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public struct Room: Hashable, Codable, Sendable, Identifiable {
    public var id: String
    public var name: String?
    public var description: String?
    public var beds: [Bed]
    public var occupancy: Occupancy
    public var amenities: Set<String>
    public var images: [ImageAsset]
    public var ratePlans: [RatePlan]
    public init(
        id: String,
        name: String? = nil,
        description: String? = nil,
        beds: [Bed] = [],
        occupancy: Occupancy,
        amenities: Set<String> = [],
        images: [ImageAsset] = [],
        ratePlans: [RatePlan]
    ) {
        self.id = id;
        self.name = name;
        self.description = description
        self.beds = beds;
        self.occupancy = occupancy;
        self.amenities = amenities
        self.images = images;
        self.ratePlans = ratePlans
    }
}
