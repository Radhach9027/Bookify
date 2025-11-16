//
//  CustomTabBar.swift
//  MyHotels
//
//  Created by radha chilamkurthy on 23/10/25.
//

import SwiftUI

public struct TabSpec: Identifiable {
    public let id: String
    public let title: String
    public let systemImage: String
    public let build: () -> AnyView

    public init<ID: CustomStringConvertible>(
        id: ID,
        title: String,
        systemImage: String,
        @ViewBuilder content: @escaping () -> some View
    ) {
        self.id = id.description
        self.title = title
        self.systemImage = systemImage
        self.build = { AnyView(content()) }
    }
}


public struct AppTabBar: View {
    @Binding var selection: String
    let specs: [TabSpec]

    public init(
        selection: Binding<String>,
        specs: [TabSpec],
    ) {
        self._selection = selection
        self.specs = specs
    }

    public var body: some View {
        TabView(selection: $selection) {
            ForEach(specs) { spec in
                spec.build()
                    .tabItem {
                        Image(systemName: spec.systemImage)
                        Text(spec.title)
                    }
                    .tag(spec.id)
            }
        }
    }
}

