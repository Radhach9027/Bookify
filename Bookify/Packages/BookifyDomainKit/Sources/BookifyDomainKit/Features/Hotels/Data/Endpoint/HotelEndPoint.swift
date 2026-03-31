//
//  HotelEndPoint.swift
//  BookifyDomainKit
//
//  Created by radha chilamkurthy on 10/11/25.
//

import BookifyModelKit
import DependencyContainer
import Foundation
import NetworkClient

enum HotelEndPoint {
    case fetch
}

extension HotelEndPoint: NetworkRequestProtocol {
    @Inject private static var config: AppConfig

    var httpMethod: NetworkRequestMethod {
        .get
    }

    var urlComponents: URLComponents? {
        switch self {
        case .fetch:
            return Self.makeComponents(path: "v1/fetch", query: ["city": "HYD"])
        }
    }

    var httpHeaderFields: NetworkHTTPHeaderField? {
        .headerFields(fields: [
            .contentType: .json,
        ])
    }

    private static func makeComponents(
        path: String,
        query: [String: String]? = nil
    ) -> URLComponents? {
        guard let url = try? config.services.url(for: "hotels", path: path, query: query) else {
            return nil
        }
        return URLComponents(url: url, resolvingAgainstBaseURL: false)
    }
}
