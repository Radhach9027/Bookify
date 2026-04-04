//
//  BookifyApp.swift
//  Bookify
//
//  Created by radha chilamkurthy on 03/11/25.
//

import BookifyDesignSystem
import Combine
import NavigatorKit
import SwiftUI
import FirebaseCore
import BookifyTelemetryKit

@main
struct BookifyApp: App {
    @StateObject private var appNav = AppNavigator()
    @StateObject private var coordinator = NavigationCoordinator()

    init() {
        FirebaseApp.configure()
        TelemetryBootstrapper.setup()
        BookifyTelemetry.track(AppEvent.appLaunched)
    }

    var body: some Scene {
        WindowGroup {
            NavigationHost(coordinator: coordinator) {
                RouteSwitchHost()
                    .environmentObject(appNav)
                    .environmentObject(coordinator)
            }
            .environmentObject(appNav)
            .environmentObject(coordinator)
            .task { await appNav.start() }
        }
    }
}
