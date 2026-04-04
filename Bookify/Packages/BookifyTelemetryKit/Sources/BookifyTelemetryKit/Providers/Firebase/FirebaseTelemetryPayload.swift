//
//  FirebaseTelemetryPayload.swift
//  BookifyTelemetryKit
//
//  Created by Radha Chandan on 03/04/26.
//

import Foundation

public struct FirebaseTelemetryPayload: Sendable {
    public let eventName: String
    public let parameters: [String: Any]

    public init(
        eventName: String,
        parameters: [String: Any]
    ) {
        self.eventName = eventName
        self.parameters = parameters
    }
}
