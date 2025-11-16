//
//  AppNavigator.swift
//  Bookify
//
//  Created by radha chilamkurthy on 07/11/25.
//

import SwiftUI
import Combine

enum AppRoute: Hashable {
    case splash, shell, launchError(String)
}

final class AppNavigator: ObservableObject {
    @Published var route: AppRoute = .splash

    @MainActor
    func start() async {
        async let minDelay: Void = Task.sleep(nanoseconds: 3_000_000_000)
        do {
            try BookifySetup.bootstrap()
            _ = try await minDelay
            route = .shell
        } catch {
            _ = try? await minDelay
            route = .launchError(error.localizedDescription)
        }
    }
}
