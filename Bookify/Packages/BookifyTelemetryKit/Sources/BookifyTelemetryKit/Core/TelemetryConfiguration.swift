//
//  TelemetryConfiguration.swift
//  BookifyTelemetryKit
//
//  Created by Radha Chandan on 03/04/26.
//

import Foundation

public struct TelemetryConfiguration: Sendable {
    public let context: TelemetryContext
    public let providers: [any TelemetryProvider]

    public init(
        context: TelemetryContext,
        providers: [any TelemetryProvider]
    ) {
        self.context = context
        self.providers = providers
    }
}
