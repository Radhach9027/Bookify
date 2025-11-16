//
//  AppConfigReader.swift
//  Bookify
//
//  Created by radha chilamkurthy on 06/11/25.
//

import Foundation
import BookifyModelKit
import BookifySharedSystem

public enum AppConfigReader {
    
    /// Pure function: reads and decodes `AppConfig` from a bundle JSON.
    /// - Parameters:
    ///   - bundle: Bundle to read from (defaults to `.module` in SPM, else `.main`)
    ///   - file: Resource name without extension (defaults to "AppConfig")
    ///   - ext: File extension (defaults to "json")
    ///   - configure: Optional decoder customization (key/date strategies, etc.)
    /// - Returns: Decoded `AppConfig`
    public static func readConfiguration(
        from bundle: Bundle = .main,
        file: String = "AppConfiguration",
        ext: String = "json",
        configure: ((JSONDecoder) -> Void)? = nil
    ) throws -> AppConfig {
        guard let url = bundle.url(forResource: file, withExtension: ext) else {
            throw JSONLoadError.fileNotFound("\(file).\(ext)")
        }
        let data: Data
        do { data = try Data(contentsOf: url) }
        catch { throw JSONLoadError.dataReadFailed(underlying: error) }
        return try JSONDecoder.decodeWithDetailedError(AppConfig.self, from: data)
    }
}
