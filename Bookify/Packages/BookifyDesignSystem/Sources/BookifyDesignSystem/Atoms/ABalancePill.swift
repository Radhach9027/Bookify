//
//  BalancePill.swift
//  MyHotels
//
//  Created by radha chilamkurthy on 23/10/25.
//

import SwiftUI

struct ABalancePill: View {
    let amount: Decimal
    var body: some View {
        VStack(spacing: 2) {
            Image(systemName: "wallet.bifold.fill")
                .imageScale(.small)
            Text(amount, format: .currency(code: "INR"))
                .font(.subheadline.weight(.semibold))
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
        .background(Capsule().fill(Color.gray.opacity(0.15)))
        .overlay(Capsule().stroke(Color.gray.opacity(0.25), lineWidth: 0.5))
    }
}

