//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public struct NightRate: Hashable, Codable, Sendable {
    public var date: String
    public var amount: Money
    public init(date: String, amount: Money) {
        self.date = date;
        self.amount = amount
    }
}
