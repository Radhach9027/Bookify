//
//  Setup.swift
//  Bookify
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation
import Hotels
import Bookings
import DependencyContainer
import BookifyModelKit
import BookifySharedSystem
import BookifyDomainKit
import UIKit

enum SetupError: Error, LocalizedError {
    case hotelsRegistrationFailed(underlying: Error)
    case bookingsRegistrationFailed(underlying: Error)

    var errorDescription: String? {
        switch self {
        case .hotelsRegistrationFailed(let e):   return "Hotels registration failed: \(e)"
        case .bookingsRegistrationFailed(let e): return "Bookings registration failed: \(e)"
        }
    }
}

struct BookifySetup {

    private struct Prerequisites: Equatable {
        let config: AppConfig
    }

    // MARK: - Public-facing entry point (internal by default)
    static func bootstrap(bundle: Bundle = .main) throws {
        let p = try makePrerequisites(from: bundle)
        try applyPrerequisites(p)
    }

    private static func makePrerequisites(
        from bundle: Bundle,
        file: String = "AppConfiguration",
        ext: String = "json"
    ) throws -> Prerequisites {
        let config = try AppConfigReader.readConfiguration(
            from: bundle,
            file: file,
            ext: ext,
            configure: nil
        )
        return Prerequisites(config: config)
    }

    private static func applyPrerequisites(_ p: Prerequisites) throws {
        
        // ✅ 1) Map buildInfo first
        let enrichedConfig = p.config.with(buildInfo: buildInfo())
        
        // ✅ 2) Register enriched config in DI
        DIContainer.shared.remove(AppConfig.self)
        DIContainer.shared.register(AppConfig.self, lifetime: .singleton) { enrichedConfig }
        
        DIContainer.shared.register(EventBusType.self, lifetime: .singleton) { EventBus() }
        
        // Register downstream modules
        do { try HotelsSetup.register() }
        catch { throw SetupError.hotelsRegistrationFailed(underlying: error) }
        
        do { try BookingsSetup.register() }
        catch { throw SetupError.bookingsRegistrationFailed(underlying: error) }
    }

    
    private static func buildInfo() -> AppBuildInfo {
        let info = Bundle.main.infoDictionary
        let appVersion = info?["CFBundleShortVersionString"] as? String ?? "-"
        let buildNumber = info?["CFBundleVersion"] as? String ?? "-"

        return AppBuildInfo(
            appVersion: appVersion,
            buildNumber: buildNumber,
            osName: UIDevice.current.systemName,          // "iOS"
            osVersion: UIDevice.current.systemVersion,   // "17.2"
            deviceModel: UIDevice.current.model,         // "iPhone"
            locale: Locale.current.identifier,           // "en_IN"
            timeZone: TimeZone.current.identifier        // "Asia/Kolkata"
        )
    }
}
