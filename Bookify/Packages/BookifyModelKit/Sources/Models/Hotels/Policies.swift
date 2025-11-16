//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public struct CancellationPolicy: Hashable, Codable, Sendable {
    public var freeUntil: String?      // free cancellation until this instant
    public var penalty: Money?       // penalty after freeUntil
    public var notes: String?
    public init(
        freeUntil: String? = nil,
        penalty: Money? = nil,
        notes: String? = nil
    ) {
        self.freeUntil = freeUntil;
        self.penalty = penalty;
        self.notes = notes
    }
}

public struct CheckInOut: Hashable, Codable, Sendable {
    public var fromTime: String?   // "14:00"
    public var untilTime: String?  // "23:00"
    public init(fromTime: String? = nil, untilTime: String? = nil) {
        self.fromTime = fromTime;
        self.untilTime = untilTime
    }
}

public struct AccessibilityInfo: Hashable, Codable, Sendable {
    public var wheelchairAccessible: Bool?
    public var elevatorAvailable: Bool?
    public var accessibleRooms: Bool?
    public var notes: String?
    public init(
        wheelchairAccessible: Bool? = nil,
        elevatorAvailable: Bool? = nil,
        accessibleRooms: Bool? = nil,
        notes: String? = nil
    ) {
        self.wheelchairAccessible = wheelchairAccessible
        self.elevatorAvailable = elevatorAvailable
        self.accessibleRooms = accessibleRooms
        self.notes = notes
    }
}

public struct Policies: Hashable, Codable, Sendable {
    public var checkIn: CheckInOut?
    public var checkOut: CheckInOut?
    public var childPolicy: String?
    public var petPolicy: String?
    public var smokePolicy: String?
    public var minCheckInAge: Int?
    public var accessibility: AccessibilityInfo?
    public init(
        checkIn: CheckInOut? = nil,
        checkOut: CheckInOut? = nil,
        childPolicy: String? = nil,
        petPolicy: String? = nil,
        smokePolicy: String? = nil,
        minCheckInAge: Int? = nil,
        accessibility: AccessibilityInfo? = nil
    ) {
        self.checkIn = checkIn; self.checkOut = checkOut
        self.childPolicy = childPolicy; self.petPolicy = petPolicy
        self.smokePolicy = smokePolicy; self.minCheckInAge = minCheckInAge
        self.accessibility = accessibility
    }
}
