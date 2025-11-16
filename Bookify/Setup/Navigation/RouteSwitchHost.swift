//
//  NavigationHost.swift
//  Bookify
//
//  Created by radha chilamkurthy on 07/11/25.
//

import SwiftUI

struct RouteSwitchHost: View {
    @EnvironmentObject private var nav: AppNavigator

    var body: some View {
        switch nav.route {
        case .splash:
            SplashView()
        case .shell:
            RootShellView()
                .transition(.opacity.combined(with: .scale))
        case .launchError(let msg):
            LaunchErrorView(message: msg) {
                Task { await nav.start() }
            }
        }
    }
}

