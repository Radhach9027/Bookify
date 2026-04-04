//
//  TelemetryBootstrapper.swift
//  Bookify
//
//  Created by Radha Chandan on 04/04/26.
//

import Foundation
import FirebaseCore
import BookifyTelemetryKit

enum TelemetryBootstrapper {
    static func setup() {
        BookifyTelemetry.configure(
            TelemetryConfiguration(
                context: TelemetryContext(
                    appName: appName,
                    appVersion: appVersion,
                    buildNumber: buildNumber,
                    platform: "iOS",
                    environment: appEnvironment
                ),
                providers: providers
            )
        )
    }

    private static var providers: [any TelemetryProvider] {
        [
            ConsoleTelemetryProvider(),
            FirebaseTelemetryProvider(
                encoder: FirebaseTelemetryEncoder(
                    contextInclusionPolicy: .defaultFields
                )
            )
        ]
    }

    private static var appName: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "Bookify"
    }

    private static var appVersion: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0.0"
    }

    private static var buildNumber: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "1"
    }

    private static var appEnvironment: String {
        #if DEBUG
        return "dev"
        #elseif STAGING
        return "qa"
        #else
        return "prod"
        #endif
    }
}
