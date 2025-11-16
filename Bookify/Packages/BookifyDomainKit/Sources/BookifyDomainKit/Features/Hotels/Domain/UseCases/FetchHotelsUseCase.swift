//
//  FetchHotelsUseCase.swift
//  BookifyDomainKit
//
//  Created by radha chilamkurthy on 10/11/25.
//

import Foundation
import BookifyModelKit

public struct FetchHotelsUseCase {
    private let repository: HotelRepositoryProtocol

    public init(repository: HotelRepositoryProtocol) {
        self.repository = repository
    }

    @discardableResult
    public func execute() async throws -> [Hotel] {
        try await repository.fetchHotels()
    }
}

