//
//  TelemetryEvent.swift
//  BookifyTelemetryKit
//
//  Created by Radha Chandan on 03/04/26.
//

import Foundation

public protocol TelemetryEvent: Sendable {
    var name: String { get }
    var parameters: [String: TelemetryValue] { get }
}
