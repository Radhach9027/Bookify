//
//  File.swift
//  BookifyModelKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import Foundation

public enum PropertyType: String, Codable, Sendable {
    case hotel, resort, apartment, homestay, hostel, villa, unknown
}

public enum Amenity: String, Codable, Sendable {
    case wifi, pool, spa, gym, parking, bar, restaurant, ac, tv, elevator, unknown
}
