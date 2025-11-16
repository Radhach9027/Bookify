//
//  AppConfig.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 06/11/25.
//

import Foundation

public struct AppConfig: Codable, Equatable {
    public let schemaVersion: String
    public let environment: AppEnvironment
    public let services: ServicesConfig
    public let features: FeatureFlags
    public let experiments: ExperimentsConfig?
    public let localization: LocalizationConfig
    public let theme: ThemeConfig
    public let telemetry: TelemetryConfig
    public let permissions: PermissionsConfig?
}
