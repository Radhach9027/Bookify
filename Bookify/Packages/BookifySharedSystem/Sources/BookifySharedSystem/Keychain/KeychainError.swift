//
//  KeychainError.swift
//  BookifySharedSystem
//
//  Created by radha chilamkurthy on 08/11/25.
//

import Foundation

public enum KeychainError: Error, LocalizedError {
    case itemNotFound
    case duplicateItem
    case unexpectedStatus(OSStatus)
    case encodingFailed
    case decodingFailed

    public var errorDescription: String? {
        switch self {
        case .itemNotFound: return "Keychain item not found."
        case .duplicateItem: return "Keychain item already exists."
        case let .unexpectedStatus(s): return "Keychain unexpected status: \(s)."
        case .encodingFailed: return "Failed to encode value."
        case .decodingFailed: return "Failed to decode value."
        }
    }
}
