//
//  MFieldCard.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 11/11/25.
//

import SwiftUI

public struct MFieldCard<Content: View>: View {
    let content: Content
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        ASurface {
            content.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
