//
//  LocalizationConfig.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 06/11/25.
//

import Foundation

public struct LocalizationConfig: Codable, Equatable {
    public let defaultLanguage: String          // "en"
    public let supported: [String]              // ["en","te","hi",...]
    public let bundles: [String: URL]           // language -> remote JSON URL
    public let fonts: [String: FontPack]        // language -> fonts
    public struct FontPack: Codable, Equatable {
        public let regular: URL
        public let medium: URL?
        public let bold: URL?
    }
}
