//
//  AppBuildInfo.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 23/11/25.
//

import Foundation

public struct AppBuildInfo: Codable, Equatable, Sendable {
    public let appVersion: String        // CFBundleShortVersionString
    public let buildNumber: String       // CFBundleVersion
    public let osName: String            // "iOS"
    public let osVersion: String         // UIDevice.current.systemVersion
    public let deviceModel: String       // e.g. "iPhone 15 Pro"
    public let locale: String            // e.g. "en_IN"
    public let timeZone: String          // e.g. "Asia/Kolkata"

    public init(
        appVersion: String,
        buildNumber: String,
        osName: String,
        osVersion: String,
        deviceModel: String,
        locale: String,
        timeZone: String
    ) {
        self.appVersion = appVersion
        self.buildNumber = buildNumber
        self.osName = osName
        self.osVersion = osVersion
        self.deviceModel = deviceModel
        self.locale = locale
        self.timeZone = timeZone
    }
}
