//
//  ExperimentsConfig.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 06/11/25.
//

import Foundation

@dynamicMemberLookup
public struct ExperimentsConfig: Codable, Equatable {
    public let ab: [String: String] // e.g. ["paywall_variant": "B", "search_empty_state": "control"]

    // Lookup helpers
    public subscript(_ key: String) -> String? { ab[key] }
    public subscript(dynamicMember member: String) -> String? { ab[member] }

    // Decode the whole object as a dictionary
    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer()
        self.ab = try value.decode([String: String].self)
    }

    // Encode back as a flat object
    public func encode(to encoder: Encoder) throws {
        var value = encoder.singleValueContainer()
        try value.encode(ab)
    }

    public init(_ ab: [String: String]) { self.ab = ab }
}
