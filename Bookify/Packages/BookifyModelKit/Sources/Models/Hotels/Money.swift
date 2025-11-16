//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public struct Money: Hashable, Codable, Sendable {
    public var amount: Decimal          // use Decimal for currency safety
    public var currencyCode: String     // ISO-4217 (e.g., "INR", "USD")
    public var isTaxInclusive: Bool?
    public var minorUnits: Int?         // 2 for INR/USD, 0 for JPY, etc.

    public init(
        amount: Decimal,
        currencyCode: String,
        isTaxInclusive: Bool? = nil,
        minorUnits: Int? = 2
    ) {
        self.amount = amount
        self.currencyCode = currencyCode
        self.isTaxInclusive = isTaxInclusive
        self.minorUnits = minorUnits
    }

    public init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        if let s = try? c.decode(String.self, forKey: .amount), let d = Decimal(string: s) {
            self.amount = d
        } else {
            self.amount = try c.decode(Decimal.self, forKey: .amount) // fallback
        }
        self.currencyCode = try c.decode(String.self, forKey: .currencyCode)
        self.isTaxInclusive = try c.decodeIfPresent(Bool.self, forKey: .isTaxInclusive)
        self.minorUnits = try c.decodeIfPresent(Int.self, forKey: .minorUnits)
    }

    public func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode("\(amount)", forKey: .amount) // encode as string for lossless transport
        try c.encode(currencyCode, forKey: .currencyCode)
        try c.encodeIfPresent(isTaxInclusive, forKey: .isTaxInclusive)
        try c.encodeIfPresent(minorUnits, forKey: .minorUnits)
    }

    enum CodingKeys: String, CodingKey { case amount, currencyCode, isTaxInclusive, minorUnits }
}
