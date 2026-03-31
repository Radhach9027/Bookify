//
//  Money.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public struct Money: Hashable, Codable, Sendable {
    public var amount: Decimal // use Decimal for currency safety
    public var currencyCode: String // ISO-4217 (e.g., "INR", "USD")
    public var isTaxInclusive: Bool?
    public var minorUnits: Int? // 2 for INR/USD, 0 for JPY, etc.

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
        let codingKey = try decoder.container(keyedBy: CodingKeys.self)
        if let stringValue = try? codingKey.decode(String.self, forKey: .amount),
           let decimal = Decimal(string: stringValue)
        {
            amount = decimal
        } else {
            amount = try codingKey.decode(Decimal.self, forKey: .amount) // fallback
        }
        currencyCode = try codingKey.decode(String.self, forKey: .currencyCode)
        isTaxInclusive = try codingKey.decodeIfPresent(Bool.self, forKey: .isTaxInclusive)
        minorUnits = try codingKey.decodeIfPresent(Int.self, forKey: .minorUnits)
    }

    public func encode(to encoder: Encoder) throws {
        var codingKey = encoder.container(keyedBy: CodingKeys.self)
        try codingKey.encode("\(amount)", forKey: .amount) // encode as string for lossless transport
        try codingKey.encode(currencyCode, forKey: .currencyCode)
        try codingKey.encodeIfPresent(isTaxInclusive, forKey: .isTaxInclusive)
        try codingKey.encodeIfPresent(minorUnits, forKey: .minorUnits)
    }

    enum CodingKeys: String, CodingKey { case amount, currencyCode, isTaxInclusive, minorUnits }
}
