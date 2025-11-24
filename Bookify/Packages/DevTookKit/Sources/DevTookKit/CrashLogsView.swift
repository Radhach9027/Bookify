//
//  CrashLogsView.swift
//  DevTookKit
//
//  Created by radha chilamkurthy on 23/11/25.
//

import SwiftUI

struct CrashLogsView: View {
    @State private var logs: String = "Loading…"
    
    var body: some View {
        ScrollView {
            Text(logs)
                .font(.caption)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onAppear {
            //logs = CrashLogReader.shared.read()
        }
    }
}
