//
//  NearbyListOrganism.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 11/11/25.
//

import SwiftUI

public struct NearbyListOrganism: View {
    let state: LoadState<[PlaceRowProps]>;
    let onRefresh: () -> Void
                            
    public init(
        state: LoadState<[PlaceRowProps]>,
        onRefresh: @escaping () -> Void
    ) {
        self.state = state;
        self.onRefresh = onRefresh
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            MSectionHeader(title: "Nearby Attractions")
            Group {
                switch state {
                case .idle, .loading:
                    VStack(spacing: 12) { ForEach(0..<3, id: \.self) { _ in
                        AShimmerPlaceRow()
                    }
                }.padding(.horizontal)
                case .failed:
                    HStack { AIcon("exclamationmark.triangle.fill"); AText("Failed to load nearby places.", style: .subheadline, color: .secondary) }.padding(.horizontal)
                case .loaded(let rows):
                    if #available(iOS 17.0, *) {
                        ScrollView { LazyVStack(spacing: 12) { ForEach(rows) { row in PlaceRowOrganism(props: row, onDirections: {}, onBook: {}) } }.padding(.horizontal).padding(.bottom, 4) }.contentMargins(.vertical, 0)
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
        }.refreshable { onRefresh() }
    }
}

