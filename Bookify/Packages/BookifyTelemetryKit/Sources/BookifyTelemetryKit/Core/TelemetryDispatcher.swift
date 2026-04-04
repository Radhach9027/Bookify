//
//  TelemetryDispatcher.swift
//  BookifyTelemetryKit
//
//  Created by Radha Chandan on 03/04/26.
//

import Foundation

final class TelemetryDispatcher: @unchecked Sendable {
    private let providers: [any TelemetryProvider]
    private let context: TelemetryContext

    init(configuration: TelemetryConfiguration) {
        self.providers = configuration.providers
        self.context = configuration.context
    }

    func track(_ event: any TelemetryEvent) {
        #if DEBUG
        assert(
            !event.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            "Telemetry event name must not be empty"
        )
        #endif

        providers.forEach { provider in
            provider.track(event: event, context: context)
        }
    }
}
