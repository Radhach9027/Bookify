//
//  FirebaseNormalization.swift
//  BookifyTelemetryKit
//
//  Created by Radha Chandan on 03/04/26.
//

import Foundation

extension String {
    func normalizedFirebaseName(maxLength: Int) -> String {
        guard !isEmpty else { return "" }

        let allowedCharacterSet = CharacterSet.alphanumerics.union(.init(charactersIn: "_"))

        let transformedScalars = lowercased().unicodeScalars.map { scalar -> Character in
            allowedCharacterSet.contains(scalar) ? Character(scalar) : "_"
        }

        var value = String(transformedScalars)

        while value.contains("__") {
            value = value.replacingOccurrences(of: "__", with: "_")
        }

        value = value.trimmingCharacters(in: CharacterSet(charactersIn: "_"))

        if let first = value.first, first.isNumber {
            value = "e_\(value)"
        }

        if value.count > maxLength {
            value = String(value.prefix(maxLength))
        }

        return value
    }
}
