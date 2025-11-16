//
//  KeychainStore.swift
//  BookifySharedSystem
//
//  Created by radha chilamkurthy on 08/11/25.
//

import Foundation
@preconcurrency import Security

public final class KeychainStore<T: Codable & Sendable> {
    
    public struct Options: Sendable {
        public enum Accessibility: Sendable {
            case afterFirstUnlockThisDeviceOnly
            case afterFirstUnlock
            case whenUnlockedThisDeviceOnly
            case whenUnlocked
            @available(*, deprecated, message: "Use .afterFirstUnlockThisDeviceOnly or .whenUnlockedThisDeviceOnly instead")
            case alwaysThisDeviceOnly
            @available(*, deprecated, message: "Use .afterFirstUnlock or .whenUnlocked instead")
            case always

            var cfString: CFString {
                switch self {
                case .afterFirstUnlockThisDeviceOnly: return kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
                case .afterFirstUnlock: return kSecAttrAccessibleAfterFirstUnlock
                case .whenUnlockedThisDeviceOnly: return kSecAttrAccessibleWhenUnlockedThisDeviceOnly
                case .whenUnlocked: return kSecAttrAccessibleWhenUnlocked
                case .alwaysThisDeviceOnly: return kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
                case .always: return kSecAttrAccessibleAfterFirstUnlock
                }
            }
        }

        /// kSecAttrAccessible*. Default: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        public var accessibility: Accessibility = .afterFirstUnlockThisDeviceOnly
        /// Whether item can sync via iCloud Keychain. Default: false
        public var synchronizable: Bool = false
        /// Optional access group if using Keychain Sharing
        public var accessGroup: String? = nil

        public init(accessibility: Accessibility = .afterFirstUnlockThisDeviceOnly,
                    synchronizable: Bool = false,
                    accessGroup: String? = nil) {
            self.accessibility = accessibility
            self.synchronizable = synchronizable
            self.accessGroup = accessGroup
        }
    }

    private let service: String
    private let account: String
    private let options: Options
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    /// Create a single-item store (service+account uniquely identify the value).
    public init(service: String, account: String, options: Options = .init()) {
        self.service = service
        self.account = account
        self.options = options
    }

    /// Save (upsert) a single value.
    public func save(_ value: T?) throws {
        guard let value else { try clear(); return }
        guard let data = try? encoder.encode(value) else { throw KeychainError.encodingFailed }

        // Base query
        var query = baseQuery()
        // Delete existing, then add
        SecItemDelete(query as CFDictionary)

        query[kSecValueData as String] = data
        query[kSecAttrAccessible as String] = options.accessibility.cfString
        if options.synchronizable { query[kSecAttrSynchronizable as String] = kCFBooleanTrue }
        if let ag = options.accessGroup { query[kSecAttrAccessGroup as String] = ag }

        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.unexpectedStatus(status) }
    }

    /// Load the single value (or nil if not found).
    public func load() throws -> T? {
        var query = baseQuery()
        query[kSecReturnData as String] = true
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        if options.synchronizable { query[kSecAttrSynchronizable as String] = kSecAttrSynchronizableAny }
        if let ag = options.accessGroup { query[kSecAttrAccessGroup as String] = ag }

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        switch status {
        case errSecItemNotFound:
            return nil
        case errSecSuccess:
            guard let data = item as? Data, let value = try? decoder.decode(T.self, from: data) else {
                throw KeychainError.decodingFailed
            }
            return value
        default:
            throw KeychainError.unexpectedStatus(status)
        }
    }

    /// Remove the single value (no error if already gone).
    public func clear() throws {
        let status = SecItemDelete(baseQuery() as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unexpectedStatus(status)
        }
    }

    // MARK: - Multi-key convenience (optional)

    /// Save under a custom key (account will be <account>.<key>)
    public func save(_ value: T?, forKey key: String) throws {
        try KeychainStore(service: service, account: namespaced(key), options: options).save(value)
    }

    /// Load under a custom key
    public func load(forKey key: String) throws -> T? {
        try KeychainStore<T>(service: service, account: namespaced(key), options: options).load()
    }

    /// Clear under a custom key
    public func clear(forKey key: String) throws {
        try KeychainStore<T>(service: service, account: namespaced(key), options: options).clear()
    }

    // MARK: - Internals

    private func baseQuery() -> [String: Any] {
        let q: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
        ]
        return q
    }

    private func namespaced(_ key: String) -> String { "\(account).\(key)" }
}

