//
//  TelemetryEncoder.swift.swift
//  BookifyTelemetryKit
//
//  Created by Radha Chandan on 03/04/26.
//

import Foundation

public struct TelemetryEncoder {
    public init() {}

    public func encode(_ envelope: TelemetryEnvelope) -> [String: Any] {
        return [
            TelemetryKeys.eventName: envelope.eventName,
            TelemetryKeys.parameters: envelope.parameters.mapValues { $0.foundationValue },
            TelemetryKeys.context: encodeContext(envelope.context),
            TelemetryKeys.timestamp: ISO8601DateFormatter().string(from: envelope.timestamp)
        ]
    }

    private func encodeContext(_ context: TelemetryContext) -> [String: Any] {
        return [
            TelemetryKeys.Context.appName: context.appName,
            TelemetryKeys.Context.appVersion: context.appVersion,
            TelemetryKeys.Context.buildNumber: context.buildNumber,
            TelemetryKeys.Context.platform: context.platform,
            TelemetryKeys.Context.environment: context.environment
        ]
    }
}
