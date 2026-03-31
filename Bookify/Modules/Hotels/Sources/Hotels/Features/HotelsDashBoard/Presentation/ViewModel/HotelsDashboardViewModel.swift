//
//  HotelsDashboardViewModel.swift
//  Hotels
//
//  Created by radha chilamkurthy on 10/11/25.
//

import BookifyDesignSystem
import BookifyDomainKit
import BookifyModelKit
import Combine
import DependencyContainer
import Foundation

@MainActor
final class HotelsDashboardViewModel: ObservableObject {
    @Published private(set) var state: LoadState<[HotelCardProps]> = .idle
    @Published var balance: Decimal = 12345.67

    func fetchHotels() {
        state = .loading
        Task {
            do {
                let hotels = try await BookifyDomain.shared.hotelsUseCase.execute()
                let cards = hotels.map { $0.toCardProps() }
                state = .loaded(cards)
            } catch {
                state = .failed
            }
        }
    }
}

private extension Hotel {
    func toCardProps() -> HotelCardProps {
        HotelCardProps(
            id: id.rawValue,
            name: name,
            city: address.city ?? "",
            ratingText: String(format: "%.1f", review?.rating ?? 0),
            ratingValue: review?.rating ?? 0,
            reviewsCountText: "(\(review?.count ?? 0))",
            priceText: "₹\(10000)",
            originalPrice: "₹\(12000)",
            description: description ?? "",
            imageUrl: images.first?.url ?? URL(string: "")!
        )
    }
}
