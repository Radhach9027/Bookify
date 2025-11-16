//
//  HomeTemplate.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 11/11/25.
//

import SwiftUI

public struct HotelDashBoardTemplate<Selection: View, Carousel: View, Nearby: View>: View {
    let selection: Selection
    let carousel: Carousel
    let nearby: Nearby
    
    public init(
        @ViewBuilder selection: () -> Selection,
        @ViewBuilder carousel: () -> Carousel,
        @ViewBuilder nearby: () -> Nearby
    ) {
        self.selection = selection();
        self.carousel = carousel();
        self.nearby = nearby()
    }
    
    public var body: some View {
        Group {
            if #available(iOS 16.0, *) {
                NavigationStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 16) {
                            selection.padding(.horizontal).padding(.top, 8)
                            MSectionHeader(title: "Popular Hotels Nearby") {
                                Button {
                                    
                                } label: {
                                    Image(systemName: "arrow.clockwise").font(.body)
                                }
                            }.padding(.horizontal)
                            carousel
                            nearby
                        }.padding(.bottom, 8)
                    }
                    .background(Color(.systemGroupedBackground))
                    .navigationTitle("Hotels")
                    .navigationBarTitleDisplayMode(.inline)
                }
            } else {
                NavigationView {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 16) {
                            selection.padding(.horizontal).padding(.top, 8)
                            MSectionHeader(title: "Popular Hotels Nearby") {
                                Button {
                                    
                                } label: {
                                    Image(systemName: "arrow.clockwise").font(.body)
                                }
                            }.padding(.horizontal)
                            carousel
                            nearby
                        }.padding(.bottom, 8)
                    }
                    .background(Color(.systemGroupedBackground))
                    .navigationTitle("Hotels")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
}
