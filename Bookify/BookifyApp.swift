//
//  BookifyApp.swift
//  Bookify
//
//  Created by radha chilamkurthy on 03/11/25.
//

import SwiftUI
import Combine
import NavigatorKit
import BookifyDesignSystem

@main
struct BookifyApp: App {
    @StateObject private var appNav = AppNavigator()
    @StateObject private var coordinator = NavigationCoordinator()

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




