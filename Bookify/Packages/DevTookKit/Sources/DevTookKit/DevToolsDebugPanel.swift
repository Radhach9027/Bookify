//
//  DevToolsDebugPanel.swift
//  DevTookKit
//
//  Created by radha chilamkurthy on 23/11/25.
//

import SwiftUI

public struct DevToolsDebugPanel: View {
    @State private var selectedTab: Tab = .debugInfo
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Picker("", selection: $selectedTab) {
                    ForEach(Tab.allCases, id: \.self) { tab in
                        Text(tab.title).tag(tab)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                // Tab content
                Group {
                    switch selectedTab {
                    case .debugInfo:       DebugInfoView()
                    case .environment:     EnvironmentView()
                    case .featureFlags:    FeatureFlagsView()
                    case .crashLogs:       CrashLogsView()
                    case .network:         NetworkInspectorView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle("Developer Tools")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension DevToolsDebugPanel {
    enum Tab: CaseIterable {
        case debugInfo, environment, featureFlags, crashLogs, network
        
        var title: String {
            switch self {
            case .debugInfo: return "Debug"
            case .environment: return "Environment"
            case .featureFlags: return "Features"
            case .crashLogs: return "Logs"
            case .network: return "Network"
            }
        }
    }
}
