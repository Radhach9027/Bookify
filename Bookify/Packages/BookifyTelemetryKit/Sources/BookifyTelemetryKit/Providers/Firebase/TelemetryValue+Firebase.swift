//
//  TelemetryValue+Firebase.swift
//  BookifyTelemetryKit
//
//  Created by Radha Chandan on 03/04/26.
//

import Foundation

extension TelemetryValue {
    var firebaseCompatibleValue: Any? {
        switch self {
        case .string(let value):
            return String(value.prefix(100))

        case .int(let value):
            return value

        case .double(let value):
            return value

        case .bool(let value):
            return value ? 1 : 0

        case .array(let values):
            return values.jsonStringRepresentation(maxLength: 100)

        case .object(let dictionary):
            return dictionary.jsonStringRepresentation(maxLength: 100)

        case .null:
            return nil
        }
    }
}
