//
//  HotelCarouselOrganism.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 11/11/25.
//

import SwiftUI

public enum LoadState<Content> {
    case idle, loading, failed, loaded(Content)
}

public struct HotelCarouselOrganism: View {
    let state: LoadState<[HotelCardProps]>
    let onRetry: () -> Void
    let onAppear: () -> Void
                            
    public init(
        state: LoadState<[HotelCardProps]>,
        onRetry: @escaping () -> Void,
        onAppear: @escaping () -> Void
    ) {
        self.state = state;
        self.onRetry = onRetry;
        self.onAppear = onAppear
    }
    
    public var body: some View {
        Group {
            switch state {
            case .idle, .loading:
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) { ForEach(0..<3, id: \.self) { _ in
                        AShimmerHotelCard()
                    }}
                    .padding(.horizontal, 16)
                }
            case .failed:
                VStack {
                    AIcon("exclamationmark.triangle.fill", size: .large).foregroundStyle(.secondary)
                    AText("Failed to load hotels", style: .subheadline, color: .secondary)
                    Button("Retry", action: onRetry).buttonStyle(.bordered).padding(.top, 6)
                }.frame(maxWidth: .infinity)
            case .loaded(let cards):
                if #available(iOS 17.0, *) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(cards) { card in
                                HotelCard(
                                    props: card,
                                    width: 295,
                                    onBook: {},
                                    onWishlist: {},
                                    onShare: {}
                                )
                            }
                        }.padding(.horizontal, 16)
                    }.scrollTargetBehavior(.paging)
                } else {
                    // Fallback on earlier versions
                }
            }
        }.onAppear(perform: onAppear)
    }
}
