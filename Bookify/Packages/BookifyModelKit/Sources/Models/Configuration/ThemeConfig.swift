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
           let value = try? single.decode(Double.self)
        {
            self = .fixed(value)
            return
        }

        let color = try decoder.container(keyedBy: CodingKeys.self)
        if let fixed = try? color.decode(Double.self, forKey: .fixed) {
            self = .fixed(fixed)
        } else if let scale = try? color.decode(Double.self, forKey: .scale) {
            self = .scale(scale)
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
        case let .fixed(value):
            try ["fixed": value].encode(to: encoder)
        case let .scale(value):
            try ["scale": value].encode(to: encoder)
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

        let color = try decoder.container(keyedBy: CodingKeys.self)
        let light = try color.decode(String.self, forKey: .light)
        let dark = try color.decode(String.self, forKey: .dark)
        let alpha = (try? color.decode(Double.self, forKey: .alpha)) ?? 1
        self = .dynamic(light: light, dark: dark, alpha: alpha)
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .solid(hex):
            var color = encoder.singleValueContainer()
            try color.encode(hex)
        case let .dynamic(light, dark, alpha):
            var color = encoder.container(keyedBy: CodingKeys.self)
            try color.encode(light, forKey: .light)
            try color.encode(dark, forKey: .dark)
            if alpha != 1 { try color.encode(alpha, forKey: .alpha) }
        }
    }
}
