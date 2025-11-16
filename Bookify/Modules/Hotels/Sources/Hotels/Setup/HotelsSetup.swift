//
//  Setup.swift
//  Hotels
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation
import NavigatorKit
import SwiftUI

@MainActor
public struct HotelsSetup {
    /// Call from app bootstrap
    public static func register() throws {
        registerRoutes()
    }

    public static func registerRoutes() {
        RouteRegistrar.registerAll(features: [HotelRoutes.self])
    }
}
