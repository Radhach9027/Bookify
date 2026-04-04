//
//  TelemetryValue+JSON.swift
//  BookifyTelemetryKit
//
//  Created by Radha Chandan on 03/04/26.
//

import Foundation

extension Dictionary where Key == String, Value == TelemetryValue {
    func jsonStringRepresentation(maxLength: Int) -> String? {
        let object = mapValues { $0.foundationValue }

        guard JSONSerialization.isValidJSONObject(object),
              let data = try? JSONSerialization.data(withJSONObject: object, options: []),
              let jsonString = String(data: data, encoding: .utf8) else {
            return nil
        }

        return String(jsonString.prefix(maxLength))
    }
}

extension Array where Element == TelemetryValue {
    func jsonStringRepresentation(maxLength: Int) -> String? {
        let object = map { $0.foundationValue }

        guard JSONSerialization.isValidJSONObject(object),
              let data = try? JSONSerialization.data(withJSONObject: object, options: []),
              let jsonString = String(data: data, encoding: .utf8) else {
            return nil
        }

        return String(jsonString.prefix(maxLength))
    }
}
