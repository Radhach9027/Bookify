//
//  HotelRepositoryImpl.swift
//  BookifyDomainKit
//
//  Created by radha chilamkurthy on 10/11/25.
//

import Foundation
import BookifyModelKit
import NetworkClient
import DependencyContainer
import BookifySharedSystem
import Combine

struct HotelRepositoryImpl: HotelRepositoryProtocol {
    @Inject()
    private var configuration: AppConfig
    private let session: CombineNetworkProtocol

    init(session: CombineNetworkProtocol) {
        self.session = session
    }

    func fetchHotels() async throws -> [Hotel] {
        switch configuration.environment {
        case .dev:
            return try ContractLoader.load("Hotels")
        default:
            let endpoint = HotelEndPoint.fetch
            let publisher: AnyPublisher<[Hotel], NetworkError> =
                session.request(for: endpoint, codable: [Hotel].self, receive: .main)
            return try await publisher.firstAsync()
        }
    }
}

// TEMP bridge: await first value from a Combine publisher.
private extension Publisher where Failure: Error {
    func firstAsync() async throws -> Output {
        try await withCheckedThrowingContinuation { cont in
            var cancellable: AnyCancellable?
            cancellable = self.first().sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        cont.resume(throwing: error)
                    }
                    cancellable?.cancel()
                },
                receiveValue: { value in
                    cont.resume(returning: value)
                    cancellable?.cancel()
                }
            )
        }
    }
}

