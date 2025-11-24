//
//  DebugInfoView.swift
//  DevTookKit
//
//  Created by radha chilamkurthy on 23/11/25.
//

import SwiftUI
import BookifyModelKit
import DependencyContainer

public struct DebugInfoView: View {
    @Inject()
    private var config: AppConfig

    public var body: some View {
        let build = config.buildInfo

        return List {
            Section("App") {
                DebugRow("Version", build?.appVersion ?? "-")
                DebugRow("Build", build?.buildNumber ?? "-")
                DebugRow("OS", "\(build?.osName ?? "-") \(build?.osVersion ?? "-")")
                DebugRow("Device", build?.deviceModel ?? "-")
                DebugRow("Locale", build?.locale ?? "-")
                DebugRow("Time Zone", build?.timeZone ?? "-")
            }

            Section("Config") {
                DebugRow("Schema Version", config.schemaVersion)
                DebugRow("Environment", config.environment.rawValue.uppercased())
            }

            Section("Services") {
                DebugRow("Base URL", "-")
            }

            Section("Features") {
                DebugRow("Flags Count", "-")
                DebugRow("Experiments", config.experiments == nil ? "None" : "Enabled")
            }

            Section("Telemetry") {
                DebugRow("Telemetry", "-")
            }

            Section("Permissions") {
                DebugRow("Debug Menu", config.permissions == nil ? "Blocked" : "Allowed")
            }
        }
    }
}


