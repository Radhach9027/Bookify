//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public struct Fee: Hashable, Codable, Sendable {
    public var name: String?
    public var amount: Money
    public init(name: String? = nil, amount: Money) {
        self.name = name;
        self.amount = amount
    }
}
