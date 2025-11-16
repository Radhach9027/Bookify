//
//  AppTopBarChrome.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 14/11/25.
//

import SwiftUI

public struct AppTopBarModifier: ViewModifier {
    let config: AppTopBarConfig
    
    public func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // LEADING
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: config.onLocationTap) {
                        ALocationPill(
                            locationImage: config.locationSymbol,
                            locationName: config.locationName
                        )
                    }
                    .buttonStyle(.plain)
                }

                // CENTER
                ToolbarItem(placement: .principal) {
                    Text(config.title)
                        .font(.headline.bold())
                        .lineLimit(1)
                }

                // TRAILING
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: config.onWallet) {
                        ABalancePill(amount: config.balance)
                    }
                    .buttonStyle(.plain)
                }
            }
    }
}

