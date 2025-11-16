//
//  ThemeConfig.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 06/11/25.
//

import Foundation

public struct ThemeConfig: Codable, Equatable {
    public let schemaVersion: String
    public let brand: String
    public let cornerRadius: Radius
    public let colors: Colors
}

// MARK: - Radius
public enum Radius: Codable, Equatable {
    case fixed(Double)
    case scale(Double)

    private enum CodingKeys: String, CodingKey { case fixed, scale }

    public init(from decoder: Decoder) throws {
        // Accept number or object
        if let single = try? decoder.singleValueContainer(),
           let value = try? single.decode(Double.self) {
            self = .fixed(value)
            return
        }

        let c = try decoder.container(keyedBy: CodingKeys.self)
        if let f = try? c.decode(Double.self, forKey: .fixed) {
            self = .fixed(f)
        } else if let s = try? c.decode(Double.self, forKey: .scale) {
            self = .scale(s)
        } else {
            throw DecodingError.typeMismatch(
                Radius.self,
                .init(codingPath: decoder.codingPath,
                      debugDescription: "Expected number or {\"fixed\"|\"scale\"}.")
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .fixed(let v):
            try ["fixed": v].encode(to: encoder)
        case .scale(let v):
            try ["scale": v].encode(to: encoder)
        }
    }
}

// MARK: - Colors
public struct Colors: Codable, Equatable {
    public let primary: ColorToken
    public let onPrimary: ColorToken
    public let background: ColorToken
    public let onBackground: ColorToken
    public let surface: ColorToken
    public let onSurface: ColorToken
    public let accent: ColorToken
    public let success: ColorToken
    public let warning: ColorToken
    public let error: ColorToken
}

// MARK: - ColorToken
public enum ColorToken: Codable, Equatable {
    case solid(String)
    case dynamic(light: String, dark: String, alpha: Double)

    private enum CodingKeys: String, CodingKey { case light, dark, alpha }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let hex = try? container.decode(String.self) {
            self = .solid(hex)
            return
        }

        let c = try decoder.container(keyedBy: CodingKeys.self)
        let light = try c.decode(String.self, forKey: .light)
        let dark = try c.decode(String.self, forKey: .dark)
        let alpha = (try? c.decode(Double.self, forKey: .alpha)) ?? 1
        self = .dynamic(light: light, dark: dark, alpha: alpha)
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .solid(let hex):
            var c = encoder.singleValueContainer()
            try c.encode(hex)
        case .dynamic(let light, let dark, let alpha):
            var c = encoder.container(keyedBy: CodingKeys.self)
            try c.encode(light, forKey: .light)
            try c.encode(dark, forKey: .dark)
            if alpha != 1 { try c.encode(alpha, forKey: .alpha) }
        }
    }
}
