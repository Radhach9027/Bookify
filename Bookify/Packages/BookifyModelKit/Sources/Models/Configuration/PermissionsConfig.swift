//
//  PermissionsConfig.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 06/11/25.
//

public struct PermissionsConfig: Codable, Equatable {
    public let requestLocationOnLaunch: Bool
    public let rationaleMessages: [String: String] // per permission
}
