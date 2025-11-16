//
//  AppTopBar.swift
//  MyHotels
//
//  Created by radha chilamkurthy on 23/10/25.
//

import SwiftUI

public struct AppTopBarView: View {
    let config: AppTopBarConfig
    
    public var body: some View {
        HStack(spacing: 0) {
            Button(action: config.onLocationTap) {
                HStack(spacing: 4) {
                    Image(systemName: config.locationSymbol)
                    Text(config.locationName)
                        .font(.caption)
                }
            }
            .buttonStyle(.plain)
            
            Spacer(minLength: 0)
            
            Text(config.title)
                .font(.headline.bold())
                .lineLimit(1)
                .truncationMode(.tail)
            
            Spacer(minLength: 0)
            
            Button(action: config.onWallet) {
                ABalancePill(amount: config.balance)
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}




