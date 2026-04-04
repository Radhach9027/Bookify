//
//  TelemetryKeys.swift
//  BookifyTelemetryKit
//
//  Created by Radha Chandan on 03/04/26.
//

enum TelemetryKeys {
    static let eventName = "event_name"
    static let parameters = "parameters"
    static let context = "context"
    static let timestamp = "timestamp"

    enum Context {
        static let appName = "app_name"
        static let appVersion = "app_version"
        static let buildNumber = "build_number"
        static let platform = "platform"
        static let environment = "environment"
    }
}
