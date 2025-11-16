//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public enum ReviewSentiment: String, Codable, Sendable { case positive, neutral, negative, unknown }

public struct ReviewAuthor: Hashable, Codable, Sendable {
    public var id: String?
    public var displayName: String?
    public var countryCode: String?
    public init(
        id: String? = nil,
        displayName: String? = nil,
        countryCode: String? = nil
    ) {
        self.id = id;
        self.displayName = displayName;
        self.countryCode = countryCode
    }
}

public struct ReviewMedia: Hashable, Codable, Sendable {
    public var url: URL
    public var width: Int?
    public var height: Int?
    public var caption: String?
    public init(
        url: URL,
        width: Int? = nil,
        height: Int? = nil,
        caption: String? = nil
    ) {
        self.url = url;
        self.width = width;
        self.height = height;
        self.caption = caption
    }
}

public struct Review: Identifiable, Hashable, Codable, Sendable {
    public var id: String
    public var title: String?
    public var message: String?                 // <- the textual review
    public var rating: Double?                  // e.g., 4.0
    public var scale: Double?                   // e.g., 5 or 10
    public var sentiment: ReviewSentiment?      // optional, if you run NLP
    public var languageCode: String?            // ISO-639-1, e.g., "en", "hi"
    public var createdAt: String?
    public var stayDate: String?                  // when guest stayed (if provided)
    public var author: ReviewAuthor?
    public var media: [ReviewMedia]?
    public var helpfulCount: Int?
    public var hotelReply: String?              // management response (optional)
    public var source: SourceMeta?              // where it came from (OTA, internal)
    public var tags: [String]?                  // e.g., "cleanliness", "staff"
    
    public init(
        id: String,
        title: String? = nil,
        message: String? = nil,
        rating: Double? = nil,
        scale: Double? = 5,
        sentiment: ReviewSentiment? = nil,
        languageCode: String? = nil,
        createdAt: String? = nil,
        stayDate: String? = nil,
        author: ReviewAuthor? = nil,
        media: [ReviewMedia]? = nil,
        helpfulCount: Int? = nil,
        hotelReply: String? = nil,
        source: SourceMeta? = nil,
        tags: [String]? = nil
    ) {
        self.id = id;
        self.title = title;
        self.message = message
        self.rating = rating;
        self.scale = scale;
        self.sentiment = sentiment
        self.languageCode = languageCode;
        self.createdAt = createdAt;
        self.stayDate = stayDate
        self.author = author;
        self.media = media;
        self.helpfulCount = helpfulCount
        self.hotelReply = hotelReply;
        self.source = source;
        self.tags = tags
    }
    
    public var normalized0to5: Double? {
        guard let r = rating, let s = scale, s > 0 else { return nil }
        return r / s * 5.0
    }
}
