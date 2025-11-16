//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public struct PriceBreakdown: Hashable, Codable, Sendable {
    public var model: PricingModel
    public var base: Money                 // base before taxes/fees
    public var taxes: [Tax]
    public var fees: [Fee]
    public var total: Money                // base + taxes + fees
    public var nightlyRates: [NightRate]   // empty when perStay
    public init(
        model: PricingModel,
        base: Money,
        taxes: [Tax] = [],
        fees: [Fee] = [],
         total: Money,
        nightlyRates: [NightRate] = []
    ) {
        self.model = model;
        self.base = base;
        self.taxes = taxes;
        self.fees = fees
        self.total = total;
        self.nightlyRates = nightlyRates
    }
}
