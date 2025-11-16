//
//  Hotels.swift
//  Hotels
//
//  Created by radha chilamkurthy on 14/11/25.
//

import SwiftUI
import BookifyDesignSystem

struct HotelList: View {
    @StateObject private var viewModel = HotelsViewModel()

    var body: some View {
        Group {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .failed:
                VStack(spacing: 8) {
                    Text("Couldn’t load hotels")
                        .font(.subheadline.weight(.semibold))
                    Button("Retry") {
                        viewModel.fetchHotels()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .loaded:
                HotelListTemplate(
                    hotels: viewModel.cards,
                    onBook: { props in viewModel.book(props: props) },
                    onWishlist: { props in viewModel.toggleWishlist(props: props) }
                )
            }
        }
        .appDetailTopBar(.init(title: "Hotels"))
        .onAppear {
            if case .idle = viewModel.state {
                viewModel.fetchHotels()
            }
        }
    }
}

