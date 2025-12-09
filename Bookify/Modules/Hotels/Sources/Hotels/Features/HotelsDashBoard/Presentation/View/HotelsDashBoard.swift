//
//  Hotels.swift
//  HotelsPage
//
//  Created by radha chilamkurthy on 06/11/25.
//
import BookifyDesignSystem
import NavigatorKit
import SwiftUI

struct HotelsDashBoard: View {
    @StateObject private var hotelsVM = HotelsDashboardViewModel()
    @State private var selectionProps = StayTypeSelectionProps()
    @EnvironmentObject private var coordinator: NavigationCoordinator

    var body: some View {
        HotelDashBoardTemplate {
            StayTypeSelectionOrganism(props: $selectionProps) { action in
                switch action {
                case .search:
                    print("Search with:", selectionProps)
                    navigateToHotelList()
                case .setType, .setHours, .setStartTime, .setCheckIn, .setCheckOut:
                    break
                }
            }
        } carousel: {
            HotelCarouselOrganism(
                state: hotelsVM.state,
                onRetry: { hotelsVM.fetchHotels() },
                onAppear: {
                    if case .idle = hotelsVM.state { hotelsVM.fetchHotels() }
                }
            )
        } nearby: {
            // Plug your NearbyListOrganism here when ready
            EmptyView()
        }
        .onAppear {
            // If you want to kick nearby as well, do it here
        }
    }

    private func navigateToHotelList() {
        coordinator.navigate(path: HotelRouteSource.list.rawValue, presentation: .push)
    }
}
