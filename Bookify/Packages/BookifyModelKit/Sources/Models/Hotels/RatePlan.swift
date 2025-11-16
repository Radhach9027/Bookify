//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public struct RatePlan: Hashable, Codable, Sendable, Identifiable {
    public var id: String
    public var name: String?
    public var mealPlan: String?                  // "Room only", "BB", "HB"
    public var cancellation: CancellationPolicy?
    public var refundable: Bool
    public var price: PriceBreakdown              // total for requested stay
    public var paymentPolicy: PaymentPolicy?
    public var inclusions: [String]?              // e.g., "airport pickup"
    public init(
        id: String,
        name: String? = nil,
        mealPlan: String? = nil,
        cancellation: CancellationPolicy? = nil,
        refundable: Bool = true,
        price: PriceBreakdown,
        paymentPolicy: PaymentPolicy? = nil,
        inclusions: [String]? = nil
    ) {
        self.id = id;
        self.name = name;
        self.mealPlan = mealPlan
        self.cancellation = cancellation;
        self.refundable = refundable
        self.price = price;
        self.paymentPolicy = paymentPolicy;
        self.inclusions = inclusions
    }
}
