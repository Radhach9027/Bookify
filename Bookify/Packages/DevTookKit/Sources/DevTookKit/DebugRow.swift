//
//  DebugRow.swift
//  DevTookKit
//
//  Created by radha chilamkurthy on 23/11/25.
//

import SwiftUI

struct DebugRow: View {
    let title: String
    let value: String
    
    init(_ title: String, _ value: String) {
        self.title = title
        self.value = value
    }
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
        }
    }
}

