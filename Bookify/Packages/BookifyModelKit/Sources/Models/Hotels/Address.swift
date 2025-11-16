//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public struct Address: Hashable, Codable, Sendable {
    public var line1: String?
    public var line2: String?
    public var city: String?
    public var state: String?
    public var postalCode: String?
    public var countryCode: String? // ISO-3166-1 alpha-2
    public init(
        line1: String? = nil,
        line2: String? = nil,
        city: String? = nil,
        state: String? = nil,
        postalCode: String? = nil,
        countryCode: String? = nil
    ) {
        self.line1 = line1;
        self.line2 = line2;
        self.city = city
        self.state = state;
        self.postalCode = postalCode;
        self.countryCode = countryCode
    }
}
