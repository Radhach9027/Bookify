//
//  RootView.swift
//  Bookify
//
//  Created by radha chilamkurthy on 06/11/25.
//

import SwiftUI
import BookifyModelKit
import BookifyDesignSystem
import DependencyContainer
import NavigatorKit

struct RootShellView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @State private var selectedTabID: String = MainTab.hotels.rawValue
    private let balance: Decimal = 1234.56
    
    private var specs: [TabSpec] {
        MainTab.allCases.map { tab in
            TabSpec(
                id: tab.rawValue,
                title: tab.title,
                systemImage: tab.systemImage
            ) {
                tab.resolvedView()
                    .environmentObject(coordinator)
            }
        }
    }
    
    private var currentTab: MainTab {
        MainTab(rawValue: selectedTabID) ?? .hotels
    }
    
    private var currentTopBarConfig: AppTopBarConfig {
        AppTopBarConfig(
            title: currentTab.title,
            balance: balance,
            locationName: "Hyderabad",
            locationSymbol: "mappin.and.ellipse",
            onLocationTap: {},
            onWallet: {}
        )
    }
    
    var body: some View {
        AppTabBar(
            selection: $selectedTabID,
            specs: specs
        )
        .appTopBar(currentTopBarConfig)
    }
}










