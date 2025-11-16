//
//  TopBarProviding.swift
//  Bookify
//
//  Created by radha chilamkurthy on 14/11/25.
//

import NavigatorKit
import BookifyDesignSystem

protocol TopBarProviding {
    func topBar(for route: Route?) -> AppTopBarConfig?
}

final class AppTopBarProvider: TopBarProviding {
    func topBar(for route: Route?) -> AppTopBarConfig? {
        guard let route else {
            return AppTopBarConfig(
                title: "Hotels & HomeStays",
                onLocationTap: {
                    // TODO: hook location picker
                },
                onWallet: {
                    // TODO: open wallet
                }
            )
        }
        
        switch route.path {
        case "hotels/list":
            return AppTopBarConfig(
                title: "Hotels & HomeStays",
                onLocationTap: {},
                onWallet: {}
            )
            
        case "profile":
            return AppTopBarConfig(
                title: "Profile",
                onLocationTap: {},
                onWallet: {}
            )
            
        default:
            return nil
        }
    }
}

