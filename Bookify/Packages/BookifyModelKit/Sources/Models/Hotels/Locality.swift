//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public struct Locality: Hashable, Codable, Sendable {
    public var countryCode: String?   // ISO-3166-1 alpha-2
    public var stateCode: String?     // ISO-3166-2
    public var city: String?
    public var area: String?          // neighborhood / district
    public var slug: String?          // SEO-friendly
    public init(
        countryCode: String? = nil,
        stateCode: String? = nil,
        city: String? = nil,
        area: String? = nil,
        slug: String? = nil
    ) {
        self.countryCode = countryCode;
        self.stateCode = stateCode
        self.city = city;
        self.area = area;
        self.slug = slug
    }
}
