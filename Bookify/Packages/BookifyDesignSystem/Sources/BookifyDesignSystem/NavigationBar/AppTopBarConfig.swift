//
//  AppTopBarConfig.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 14/11/25.
//

import Foundation

public struct AppTopBarConfig {
    public var title: String
    public var balance: Decimal
    public var locationName: String
    public var onLocationTap: () -> Void
    public var onWallet: () -> Void
    public var locationSymbol: String

    public init(
        title: String,
        balance: Decimal = 2345.67,
        locationName: String = "Hyderabad",
        locationSymbol: String = "mappin.and.ellipse",
        onLocationTap: @escaping () -> Void,
        onWallet: @escaping () -> Void,
    ) {
        self.title = title
        self.balance = balance
        self.locationName = locationName
        self.onLocationTap = onLocationTap
        self.onWallet = onWallet
        self.locationSymbol = locationSymbol
    }
}
