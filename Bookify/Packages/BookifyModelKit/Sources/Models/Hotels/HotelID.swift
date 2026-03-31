//
//  HotelID.swift
//  BookifyDomainKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public struct HotelID: Hashable, Codable, Sendable, ExpressibleByStringLiteral, CustomStringConvertible {
    public let rawValue: String
    public init(_ raw: String) { rawValue = raw }
    public init(stringLiteral value: String) { rawValue = value }
    public var description: String { rawValue }
}
