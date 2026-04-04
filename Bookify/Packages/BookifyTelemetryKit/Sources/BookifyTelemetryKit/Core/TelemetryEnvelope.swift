//
//  TelemetryEnvelope.swift
//  BookifyTelemetryKit
//
//  Created by Radha Chandan on 03/04/26.
//

import Foundation

public struct TelemetryEnvelope: Sendable {
    public let eventName: String
    public let parameters: [String: TelemetryValue]
    public let context: TelemetryContext
    public let timestamp: Date

    public init(
        event: any TelemetryEvent,
        context: TelemetryContext,
        timestamp: Date = Date()
    ) {
        self.eventName = event.name
        self.parameters = event.parameters
        self.context = context
        self.timestamp = timestamp
    }
}
