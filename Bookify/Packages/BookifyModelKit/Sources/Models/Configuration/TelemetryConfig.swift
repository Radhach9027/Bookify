//
//  TelemetryConfig.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 06/11/25.
//

public struct TelemetryConfig: Codable, Equatable {
    public let vendor: String                   // "Firebase","Segment","Amplitude"
    public let apiKey: String?
    public let samplingRate: Double?            // 0...1
}
