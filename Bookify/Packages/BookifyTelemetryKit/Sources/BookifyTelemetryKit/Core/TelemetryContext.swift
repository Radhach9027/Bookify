//
//  TelemetryContext.swift
//  BookifyTelemetryKit
//
//  Created by Radha Chandan on 03/04/26.
//

import Foundation

public struct TelemetryContext: Sendable, Equatable {
    public let appName: String
    public let appVersion: String
    public let buildNumber: String
    public let platform: String
    public let environment: String

    public init(
        appName: String,
        appVersion: String,
        buildNumber: String,
        platform: String = "iOS",
        environment: String
    ) {
        self.appName = appName
        self.appVersion = appVersion
        self.buildNumber = buildNumber
        self.platform = platform
        self.environment = environment
    }
}
