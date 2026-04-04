//
//  File.swift
//  BookifyTelemetryKit
//
//  Created by Radha Chandan on 03/04/26.
//

import Foundation

public struct ConsoleTelemetryProvider: TelemetryProvider {
    private let encoder = TelemetryEncoder()

    public init() {}

    public func track(event: any TelemetryEvent, context: TelemetryContext) {
        let envelope = TelemetryEnvelope(event: event, context: context)
        let payload = encoder.encode(envelope)

        print("📡 TELEMETRY => \(payload)")
    }
}
