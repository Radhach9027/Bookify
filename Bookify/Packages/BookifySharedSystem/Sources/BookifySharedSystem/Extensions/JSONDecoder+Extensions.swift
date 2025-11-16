//
//  JSONDecoder+Extensions.swift
//  BookifySharedSystem
//
//  Created by radha chilamkurthy on 06/11/25.
//

import Foundation


public extension JSONDecoder {

    static func decodeWithDetailedError<T: Decodable>(
        _ type: T.Type,
        from data: Data,
        configure: ((JSONDecoder) -> Void)? = nil
    ) throws -> T {
        let decoder = JSONDecoder()
        configure?(decoder)

        do {
            return try decoder.decode(T.self, from: data)
        } catch let DecodingError.dataCorrupted(context) {
            logDecodingError(
                rootType: T.self,
                errorKind: "dataCorrupted",
                expectedType: nil,
                context: context
            )
            throw DecodingError.dataCorrupted(context)

        } catch let DecodingError.keyNotFound(key, context) {
            logDecodingError(
                rootType: T.self,
                errorKind: "keyNotFound('\(key.stringValue)')",
                expectedType: nil,
                context: context
            )
            throw DecodingError.keyNotFound(key, context)

        } catch let DecodingError.valueNotFound(value, context) {
            logDecodingError(
                rootType: T.self,
                errorKind: "valueNotFound(\(value))",
                expectedType: nil,
                context: context
            )
            throw DecodingError.valueNotFound(value, context)

        } catch let DecodingError.typeMismatch(expectedType, context) {
            logDecodingError(
                rootType: T.self,
                errorKind: "typeMismatch",
                expectedType: expectedType,
                context: context
            )
            throw DecodingError.typeMismatch(expectedType, context)

        } catch {
            print("❌ [Decoding] \(T.self): unknown error:", error)
            throw error
        }
    }

    // MARK: - Private logging helper

    private static func logDecodingError(
        rootType: Any.Type,
        errorKind: String,
        expectedType: Any.Type?,
        context: DecodingError.Context
    ) {
        let keyName  = context.codingPath.last?.stringValue ?? "<root>"
        let prettyPath = prettyCodingPath(
            rootType: rootType,
            codingPath: context.codingPath
        )

        print("❌ [Decoding] \(rootType) – \(errorKind)")
        if let expectedType {
            print("   Property type: \(expectedType)")
        }
        print("   Debug:   \(context.debugDescription)")
        print("   Field:   \(keyName)")
        print("   At:      \(prettyPath)")
    }

    private static func prettyCodingPath(
        rootType: Any.Type,
        codingPath: [CodingKey]
    ) -> String {
        guard !codingPath.isEmpty else {
            return "\(rootType)"
        }

        var parts: [String] = ["\(rootType)"]

        for key in codingPath {
            if let intValue = key.intValue {
                parts[parts.count - 1] += "[\(intValue)]"
            } else {
                parts.append(key.stringValue)
            }
        }

        return parts.joined(separator: ".")
    }
}

