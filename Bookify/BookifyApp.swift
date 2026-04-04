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
import UIKit
import FirebaseCore
import BookifyTelemetryKit

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct BookifyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var appNav = AppNavigator()
    @StateObject private var coordinator = NavigationCoordinator()

    init() {
        TelemetryBootstrapper.setup()
        BookifyTelemetry.track(AppEvent.appLaunched(source: .coldStart))
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

