//
//  TelemetryProvider.swift
//  BookifyTelemetryKit
//
//  Created by Radha Chandan on 03/04/26.
//

import Foundation

public protocol TelemetryProvider: Sendable {
    func track(event: any TelemetryEvent, context: TelemetryContext)
}
