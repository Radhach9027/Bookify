//
//  BookifyTokenPair.swift
//  BookifyAuthentication
//
//  Created by radha chilamkurthy on 08/11/25.
//

import Foundation

public struct BookifyTokenPair: Codable, Sendable {
    public let accessToken: String
    public let refreshToken: String?
    public let idToken: String?
    public let expiresAt: Date
    public let tokenType: String

    public var isExpiringSoon: Bool {
        // refresh slightly early (± 45s skew)
        Date().addingTimeInterval(45) >= expiresAt
    }
}
