//
//  HotelRepositoryInterface.swift
//  BookifyDomainKit
//
//  Created by radha chilamkurthy on 10/11/25.
//

import BookifyModelKit

public protocol HotelRepositoryProtocol {
    func fetchHotels() async throws -> [Hotel]
}
