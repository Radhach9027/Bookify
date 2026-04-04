//
//  FirebaseParameterMapping.swift
//  BookifyTelemetryKit
//
//  Created by Radha Chandan on 03/04/26.
//

import Foundation

public protocol FirebaseParameterMapping: Sendable {
    func map(_ parameters: [String: TelemetryValue]) -> [String: Any]
}

public struct DefaultFirebaseParameterMapper: FirebaseParameterMapping {
    public init() {}

    public func map(_ parameters: [String: TelemetryValue]) -> [String: Any] {
        var result: [String: Any] = [:]

        for (key, value) in parameters {
            let normalizedKey = key.normalizedFirebaseName(maxLength: 40)
            guard !normalizedKey.isEmpty else { continue }

            if let compatibleValue = value.firebaseCompatibleValue {
                result[normalizedKey] = compatibleValue
            }
        }

        return result
    }
}
