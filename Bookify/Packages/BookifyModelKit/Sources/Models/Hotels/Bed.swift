//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public struct Bed: Hashable, Codable, Sendable {
    public var type: String       // "King", "Queen", "Twin"
    public var count: Int
    public init(type: String, count: Int) {
        self.type = type;
        self.count = count
    }
}

public struct Occupancy: Hashable, Codable, Sendable {
    public var adults: Int
    public var children: Int
    public init(adults: Int, children: Int = 0) {
        self.adults = adults;
        self.children = children
    }
}
