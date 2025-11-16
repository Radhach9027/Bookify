//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public enum PaymentMethod: String, Codable, Sendable { case prepay, payAtHotel, mixed }

public struct PaymentPolicy: Hashable, Codable, Sendable {
    public var method: PaymentMethod
    public var requiresCardGuarantee: Bool
    public var prepayPercent: Int?          // e.g., 20% now
    public var holdAmount: Money?           // pre-auth hold
    public var notes: String?
    public init(
        method: PaymentMethod,
        requiresCardGuarantee: Bool,
        prepayPercent: Int? = nil,
        holdAmount: Money? = nil,
        notes: String? = nil
    ) {
        self.method = method;
        self.requiresCardGuarantee = requiresCardGuarantee
        self.prepayPercent = prepayPercent;
        self.holdAmount = holdAmount;
        self.notes = notes
    }
}
