//
//  ServicesConfig.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 06/11/25.
//

import Foundation

public struct ServicesConfig: Codable, Equatable {
    public let defaults: Defaults?
    public let services: [String: Endpoint]

    // MARK: - Nested Models
    public struct Defaults: Codable, Equatable {
        public let scheme: Scheme?
        public let port: Int?
        public let timeouts: Timeouts?
    }

    public struct Endpoint: Codable, Equatable {
        public let scheme: Scheme?
        public let host: String
        public let port: Int?
        public let timeouts: Timeouts?
        
        public func origin(inheriting d: Defaults?) -> URL? {
            var components = URLComponents()
            components.scheme = (scheme ?? d?.scheme)?.rawValue
            components.host = host
            components.port = port ?? d?.port
            return components.url
        }
        
        public func url(
            inheriting d: Defaults?,
            path: String = "",
            query: [String: String]? = nil
        ) throws -> URL {
            guard let base = origin(inheriting: d) else {
                throw URLError(.badURL)
            }
            var comps = URLComponents(url: base, resolvingAgainstBaseURL: false)!
            let trimmed = path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
            comps.path = trimmed.isEmpty ? "" : "/" + trimmed
            if let q = query, !q.isEmpty {
                comps.queryItems = q.map { URLQueryItem(name: $0.key, value: $0.value) }
            }
            guard let final = comps.url else { throw URLError(.badURL) }
            return final
        }
    }

    // MARK: - Shared Models
    public enum Scheme: String, Codable, Equatable {
        case http
        case https
    }

    public struct Timeouts: Codable, Equatable {
        public let connect: Double
        public let read: Double
    }

    // MARK: - Helpers
    public func url(for service: String, path: String = "", query: [String:String]? = nil) throws -> URL {
        guard let endpoint = services[service] else {
            throw URLError(.unsupportedURL)
        }
        return try endpoint.url(inheriting: defaults, path: path, query: query)
    }
}
