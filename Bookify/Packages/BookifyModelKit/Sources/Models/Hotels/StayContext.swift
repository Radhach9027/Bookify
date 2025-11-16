//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public struct StayContext: Hashable, Codable, Sendable {
    public var checkIn: String
    public var checkOut: String
    public var rooms: Int
    public var adults: Int
    public var children: Int
    public init(
        checkIn: String,
        checkOut: String,
        rooms: Int = 1,
        adults: Int = 2,
        children: Int = 0
    ) {
        self.checkIn = checkIn;
        self.checkOut = checkOut
        self.rooms = rooms;
        self.adults = adults;
        self.children = children
    }
}

public struct HotelAvailability: Hashable, Codable, Sendable {
    public var context: StayContext
    public var fetchedAt: String
    public init(context: StayContext, fetchedAt: String = .init()) {
        self.context = context;
        self.fetchedAt = fetchedAt
    }
}
