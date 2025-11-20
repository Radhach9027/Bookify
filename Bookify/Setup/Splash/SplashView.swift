//
//  SplashView.swift
//  Bookify
//
//  Created by radha chilamkurthy on 06/11/25.
//

import SwiftUI

struct SplashView: View {
    @State private var glow = false
    @State private var scale: CGFloat = 0.96
    var body: some View {
        ZStack {
            LinearGradient(colors: [.black, .black.opacity(0.86)],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            VStack(spacing: 12) {
                Image(systemName: "building.2.crop.circle.fill")
                    .resizable().scaledToFit().frame(width: 96, height: 96)
                    .foregroundStyle(.white)
                    .scaleEffect(scale)
                    .shadow(color: .white.opacity(glow ? 0.45 : 0), radius: glow ? 18 : 0)
                Text("Bookify").font(.title2.bold()).foregroundStyle(.white)
                Text("Finding stays you’ll love…")
                    .font(.subheadline).foregroundStyle(.white.opacity(0.7))
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true)) {
                glow.toggle();
                scale = 1.02
            }
        }
    }
}
