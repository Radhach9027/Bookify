//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public struct ReviewSummary: Hashable, Codable, Sendable {
    public var rating: Double?      // average rating on `scale`
    public var scale: Double?       // 5 or 10
    public var count: Int?          // total number of reviews

    // Optional distribution, e.g., buckets 1..5 → counts
    public var histogram: [Int:Int]?   // key = star (1..5), value = count

    // Recent snippet to display quickly (title or message of a recent good review)
    public var recentSnippet: String?

    // Quick picks (IDs if you want to fetch full reviews), or inline examples
    public var topPositiveReviewID: String?
    public var topNegativeReviewID: String?

    public init(
        rating: Double? = nil,
        scale: Double? = 5,
        count: Int? = nil,
        histogram: [Int:Int]? = nil,
        recentSnippet: String? = nil,
        topPositiveReviewID: String? = nil,
        topNegativeReviewID: String? = nil
    ) {
        self.rating = rating;
        self.scale = scale;
        self.count = count
        self.histogram = histogram;
        self.recentSnippet = recentSnippet
        self.topPositiveReviewID = topPositiveReviewID
        self.topNegativeReviewID = topNegativeReviewID
    }

    public var normalized0to5: Double? {
        guard let rating, let scale, scale > 0 else { return nil }
        return rating / scale * 5.0
    }
}

