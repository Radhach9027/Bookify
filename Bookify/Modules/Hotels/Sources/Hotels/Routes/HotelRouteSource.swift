//
//  HotelRouteSource.swift
//  Hotels
//
//  Created by Radha Chandan on 09/12/25.
//

enum HotelRouteSource: String, CaseIterable {
    case list
}

extension HotelRouteSource {
    var path: String {
        switch self {
        case .list:
            return "hotelList"
        }
    }
}
