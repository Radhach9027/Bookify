//
//  LaunchErrorView.swift
//  Bookify
//
//  Created by radha chilamkurthy on 06/11/25.
//

import SwiftUI

struct LaunchErrorView: View {
    let message: String
    let onRetry: () -> Void
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 44)).foregroundStyle(.yellow)
            Text("Setup Failed").font(.title3).bold()
            Text(message).foregroundStyle(.secondary)
                .multilineTextAlignment(.center).padding(.horizontal)
            Button("Retry", action: onRetry).buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
