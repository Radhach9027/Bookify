//
//  BookifyAuthError.swift
//  BookifyAuthentication
//
//  Created by radha chilamkurthy on 08/11/25.
//

import Foundation

public enum BookifyAuthError: Error, LocalizedError {
    case notConfigured
    case cancelled
    case codeMissing
    case badHTTPStatus(Int)
    case decodingFailed
    case tokenUnavailable
    case refreshUnavailable
    case keychain(OSStatus)
    case unknown

    public var errorDescription: String? {
        switch self {
        case .notConfigured: return "Authentication is not configured."
        case .cancelled: return "Authentication was cancelled."
        case .codeMissing: return "Authorization code missing in callback."
        case let .badHTTPStatus(error): return "HTTP error: \(error)."
        case .decodingFailed: return "Failed to decode token response."
        case .tokenUnavailable: return "No token available."
        case .refreshUnavailable: return "No refresh token available."
        case let .keychain(status): return "Keychain error: \(status)."
        case .unknown: return "Unknown error."
        }
    }
}
