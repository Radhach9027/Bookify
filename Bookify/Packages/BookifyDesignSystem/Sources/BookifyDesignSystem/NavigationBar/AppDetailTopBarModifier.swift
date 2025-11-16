//
//  AppDetailTopBarModifier.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 14/11/25.
//

import SwiftUI

public struct AppDetailTopBarConfig {
    public var title: String

    public init(title: String) {
        self.title = title
    }
}


public struct AppDetailTopBarModifier: ViewModifier {
    let config: AppDetailTopBarConfig
    
    public func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(false)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(config.title)
                        .font(.headline.bold())
                        .lineLimit(1)
                }
            }
    }
}
