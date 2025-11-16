//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public struct ContactInfo: Hashable, Codable, Sendable {
    public var phone: String?
    public var email: String?
    public var website: URL?
    public init(
        phone: String? = nil,
        email: String? = nil,
        website: URL? = nil
    ) {
        self.phone = phone;
        self.email = email;
        self.website = website
    }
}
