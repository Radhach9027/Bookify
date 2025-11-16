//
//  MSectionHeader.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 11/11/25.
//

import SwiftUI

public struct MSectionHeader: View {
    let title: String
    let trailing: AnyView?
    
    public init(title: String, @ViewBuilder trailing: () -> some View = { EmptyView() }) {
        self.title = title;
        let view = trailing();
        self.trailing = (view is EmptyView) ? nil : AnyView(view)
    }
    
    public var body: some View {
        HStack {
            AText(title, style: .title3Bold)
            Spacer()
            if let trailing { trailing }
        }.padding(.horizontal)
    }
}
