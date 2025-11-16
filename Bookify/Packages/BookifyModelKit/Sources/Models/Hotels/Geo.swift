//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public struct Geo: Hashable, Codable, Sendable {
    public var lat: Double
    public var lon: Double
    public var geohash: String?
    public init(
        lat: Double,
        lon: Double,
        geohash: String? = nil
    ) {
        self.lat = lat;
        self.lon = lon;
        self.geohash = geohash
    }
}
