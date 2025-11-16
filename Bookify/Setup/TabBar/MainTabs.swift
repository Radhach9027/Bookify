//
//  MainTabs.swift
//  Bookify
//
//  Created by radha chilamkurthy on 07/11/25.
//

import Foundation
import SwiftUI
import NavigatorKit

enum MainTab: String, CaseIterable, Hashable {
    case hotels, booking, pass, favourites, profile
}

extension MainTab {
    var id: String { rawValue }

    var title: String {
        switch self {
        case .hotels:  return "Hotels"
        case .booking: return "Bookings"
        case .pass:    return "My Pass"
        case .favourites : return "Favourites"
        case .profile: return "Profile"
        }
    }

    var systemImage: String {
        switch self {
        case .hotels:  return "bed.double.fill"
        case .booking: return "calendar.badge.clock"
        case .pass:    return "ticket.fill"
        case .profile: return "person.fill"
        case .favourites: return "heart.fill"
        }
    }
    
    var routePath: String {
        switch self {
        case .hotels:     return "/hotelsDashBoard"
        case .booking:    return "/bookings"
        case .favourites: return "/favourites"
        case .pass:       return "/pass"
        case .profile:    return "/profile"
        }
    }
    
    func resolvedView() -> AnyView {
        RouteRegistry.shared.resolve(path: routePath) ?? errorView()
    }
    
    private func errorView(onRetry: @escaping () -> Void = {}) -> AnyView {
        AnyView(
            LaunchErrorView(
                message: "Couldn't load \(title) Module",
                onRetry: onRetry
            )
        )
    }
}
