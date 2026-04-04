//
//  AppEvent.swift
//  Bookify
//
//  Created by radha chilamkurthy on 04/04/26.
//

import BookifyTelemetryKit

public enum LaunchSource: String, Sendable {
    case coldStart = "cold_start"
    case background = "background"
    case push = "push"
    case deepLink = "deeplink"
}

public enum AppEvent: TelemetryEvent {
    case appLaunched(source: LaunchSource)

    public var name: String {
        "app_launched"
    }

    public var parameters: [String: TelemetryValue] {
        switch self {
        case .appLaunched(let source):
            return [
                "launch_source": .string(source.rawValue)
            ]
        }
    }
}
