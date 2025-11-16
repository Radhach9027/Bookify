//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 03/11/25.
//

import Foundation

@AutoMappable(from: UserModel.self)
struct UserEntity: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
    let email: String?
    let phoneNumber: String?
    let avatarURL: URL?
    let isPremium: Bool
    let joinedDate: Date?
    let lastLogin: Date?
    let preferences: UserPreferencesEntity?
}

struct UserPreferencesEntity: Hashable, Sendable, Codable {
    var preferredLanguage: String
    var theme: String
    var notificationsEnabled: Bool
}


extension UserEntity {
    func toModel() -> UserModel {
        UserModel(
            id: id,
            fullName: name,
            email: email,
            phone: phoneNumber,
            avatar: avatarURL?.absoluteString,
            premium: isPremium,
            joinedAt: joinedDate,
            lastActive: lastLogin,
            preferences: preferences?.toModel()
        )
    }
}

extension UserPreferencesEntity {
    func toModel() -> UserPreferencesModel {
        UserPreferencesModel(
            language: preferredLanguage,
            theme: theme,
            notificationsEnabled: notificationsEnabled
        )
    }
}
