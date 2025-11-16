//
//  AIcon.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 11/11/25.
//

import SwiftUI

public struct AIcon: View {
    let systemName: String
    let size: Image.Scale
    
    public init(_ systemName: String, size: Image.Scale = .medium) {
        self.systemName = systemName;
        self.size = size
    }
    
    public var body: some View {
        Image(systemName: systemName)
            .imageScale(size)
    }
}
