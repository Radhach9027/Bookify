//
//  FeatureFlags.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 06/11/25.
//

@dynamicMemberLookup
public struct FeatureFlags: Codable, Equatable {
    public let raw: [String: Bool]

    // Lookup by string key: features["new_checkout"]
    public subscript(_ key: String) -> Bool { raw[key] ?? false }

    // Nice sugar: features.new_checkout
    public subscript(dynamicMember member: String) -> Bool { raw[member] ?? false }

    // Decode the whole object as a dictionary
    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer()
        self.raw = try value.decode([String: Bool].self)
    }

    // Encode back as a flat object
    public func encode(to encoder: Encoder) throws {
        var value = encoder.singleValueContainer()
        try value.encode(raw)
    }

    // Convenience init for tests
    public init(_ raw: [String: Bool]) { self.raw = raw }
}
