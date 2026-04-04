//
//  FirebaseEventNameMapping.swift
//  BookifyTelemetryKit
//
//  Created by Radha Chandan on 03/04/26.
//

import Foundation

public protocol FirebaseEventNameMapping: Sendable {
    func map(_ eventName: String) -> String
}

public struct DefaultFirebaseEventNameMapper: FirebaseEventNameMapping {
    public init() {}

    public func map(_ eventName: String) -> String {
        eventName.normalizedFirebaseName(maxLength: 40)
    }
}
