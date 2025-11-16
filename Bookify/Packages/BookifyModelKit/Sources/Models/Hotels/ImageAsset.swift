//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public struct ImageAsset: Hashable, Codable, Sendable {
    public var url: URL
    public var width: Int?
    public var height: Int?
    public var caption: String?
    public var kind: String?      // "exterior", "room", "amenity"
    public init(
        url: URL,
        width: Int? = nil,
        height: Int? = nil,
        caption: String? = nil,
        kind: String? = nil
    ) {
        self.url = url;
        self.width = width;
        self.height = height
        self.caption = caption;
        self.kind = kind
    }
}
