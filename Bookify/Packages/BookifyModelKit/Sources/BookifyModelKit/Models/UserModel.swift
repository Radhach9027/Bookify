//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 03/11/25.
//

import Foundation

public struct UserModel: Codable, Hashable, Identifiable, Sendable {
    public let id: String
    public let fullName: String
    public let email: String?
    public let phone: String?
    public let avatar: String?
    public let premium: Bool
    public let joinedAt: Date?
    public let lastActive: Date?
    public let preferences: UserPreferencesModel?

    public init(
        id: String,
        fullName: String,
        email: String? = nil,
        phone: String? = nil,
        avatar: String? = nil,
        premium: Bool = false,
        joinedAt: Date? = nil,
        lastActive: Date? = nil,
        preferences: UserPreferencesModel? = nil
    ) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.phone = phone
        self.avatar = avatar
        self.premium = premium
        self.joinedAt = joinedAt
        self.lastActive = lastActive
        self.preferences = preferences
    }
}

public struct UserPreferencesModel: Codable, Hashable, Sendable {
    public var language: String
    public var theme: String
    public var notificationsEnabled: Bool

    public init(
        language: String = "en",
        theme: String = "system",
        notificationsEnabled: Bool = true
    ) {
        self.language = language
        self.theme = theme
        self.notificationsEnabled = notificationsEnabled
    }
}

extension UserModel {
    func toEntity() -> UserEntity {
        UserEntity(
            id: id,
            name: fullName,
            email: email,
            phoneNumber: phone,
            avatarURL: avatar.flatMap(URL.init(string:)),
            isPremium: premium,
            joinedDate: joinedAt,
            lastLogin: lastActive,
            preferences: preferences?.toEntity()
        )
    }
}

extension UserPreferencesModel {
    func toEntity() -> UserPreferencesEntity {
        UserPreferencesEntity(
            preferredLanguage: language,
            theme: theme,
            notificationsEnabled: notificationsEnabled
        )
    }
}
