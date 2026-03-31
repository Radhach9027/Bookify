//
//  HotelRoutes.swift
//  Hotels
//
//  Created by radha chilamkurthy on 07/11/25.
//

import NavigatorKit
import SwiftUI

enum HotelRoutes: RoutableFeature {
    static var routes: [String: AnyView] {
        [
            "/hotelsDashBoard": AnyView(HotelsDashBoard()),
            "hotelList": AnyView(HotelList()),
            "/hotel/detail": AnyView(HotelDetailPage()),
        ]
    }
}
