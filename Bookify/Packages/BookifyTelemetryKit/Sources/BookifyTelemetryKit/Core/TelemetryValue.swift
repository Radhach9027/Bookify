//
//  File.swift
//  BookifyTelemetryKit
//
//  Created by Radha Chandan on 03/04/26.
//

import Foundation

public enum TelemetryValue: Sendable, Equatable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case array([TelemetryValue])
    case object([String: TelemetryValue])
    case null
}

public extension TelemetryValue {
    var foundationValue: Any {
        switch self {
        case .string(let value):
            return value
        case .int(let value):
            return value
        case .double(let value):
            return value
        case .bool(let value):
            return value
        case .array(let values):
            return values.map { $0.foundationValue }
        case .object(let dictionary):
            return dictionary.mapValues { $0.foundationValue }
        case .null:
            return NSNull()
        }
    }
}
