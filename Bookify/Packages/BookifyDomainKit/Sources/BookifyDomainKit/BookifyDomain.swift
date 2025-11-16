//
//  BookifyDomain.swift
//  BookifyDomainKit
//
//  Created by radha chilamkurthy on 05/11/25.
//

import BookifyModelKit
import NetworkClient

public final class BookifyDomain {
    public static let shared = BookifyDomain()
    public let hotelsUseCase: FetchHotelsUseCase
    private static let client: CombineNetworkProtocol = {
        let network = CombineNetwork(config: .defaultWithCustomTimeOuts(
            identifier: "BookifyDomain",
            queue: nil,
            timeoutIntervalForRequest: 30,
            timeoutIntervalForResource: 30
        ))
        return network
    }()

    private init() {
        let repo = HotelRepositoryImpl(session: BookifyDomain.client)
        self.hotelsUseCase = FetchHotelsUseCase(repository: repo)
    }
}


