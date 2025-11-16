//
//  Bundle+Extensions.swift
//  BookifySharedSystem
//
//  Created by radha chilamkurthy on 06/11/25.
//

import Foundation

public enum JSONLoadError: Error, LocalizedError {
    case fileNotFound(String)
    case dataReadFailed(underlying: Error)

    public var errorDescription: String? {
        switch self {
        case .fileNotFound(let name):         return "JSON file not found: \(name)"
        case .dataReadFailed(let underlying): return "Failed to read JSON data: \(underlying)"
        }
    }
}

public extension Bundle {
    /// Load raw Data for a resource in this bundle.
    func jsonData(
        named name: String,
        withExtension ext: String = "json",
        subdirectory: String? = nil
    ) throws -> Data {
        guard let url = url(forResource: name, withExtension: ext, subdirectory: subdirectory) else {
            throw JSONLoadError.fileNotFound("\(name).\(ext)")
        }
        do {
            return try Data(contentsOf: url)
        } catch {
            throw JSONLoadError.dataReadFailed(underlying: error)
        }
    }

    /// Decode a JSON resource in this bundle into any Decodable type using `decodeWithDetailedError`.
    func decodeJSON<T: Decodable>(
        _ type: T.Type,
        named name: String,
        withExtension ext: String = "json",
        subdirectory: String? = nil,
        configure: ((JSONDecoder) -> Void)? = nil
    ) throws -> T {
        let data = try jsonData(named: name, withExtension: ext, subdirectory: subdirectory)
        return try JSONDecoder.decodeWithDetailedError(type, from: data, configure: configure)
    }

    /// Convenience that infers `T` from the call site.
    func decodeJSON<T: Decodable>(
        named name: String,
        withExtension ext: String = "json",
        subdirectory: String? = nil,
        configure: ((JSONDecoder) -> Void)? = nil
    ) throws -> T {
        try decodeJSON(T.self, named: name, withExtension: ext, subdirectory: subdirectory, configure: configure)
    }
}
