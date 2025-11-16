//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public struct ProviderRef: Hashable, Codable, Sendable {
    public var providerCode: String?     // "HCOM", "Amadeus", "Internal"
    public var providerHotelID: String?
    public init(providerCode: String? = nil, providerHotelID: String? = nil) {
        self.providerCode = providerCode;
        self.providerHotelID = providerHotelID
    }
}

public struct SourceMeta: Hashable, Codable, Sendable {
    public var provider: String?
    public var fetchedAt: String?
    public var version: String?
    public var etag: String?
    
    public init(
        provider: String? = nil,
        fetchedAt: String? = nil,
        version: String? = nil,
        etag: String? = nil
    ) {
        self.provider = provider;
        self.fetchedAt = fetchedAt
        self.version = version;
        self.etag = etag
    }
}
