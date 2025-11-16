//
//  EventBus.swift
//  BookifySharedSystem
//
//  Created by radha chilamkurthy on 07/11/25.
//

import Foundation
import Combine

public protocol AppEvent {}
public protocol AppRequest { associatedtype Response }

public protocol EventBusType {
    // Events
    func publish<E: AppEvent>(_ event: E)
    func publisher<E: AppEvent>(_ type: E.Type) -> AnyPublisher<E, Never>

    // Requests
    func register<R: AppRequest>(_ type: R.Type,
                                 handler: @escaping (R) async throws -> R.Response)
    func unregister<R: AppRequest>(_ type: R.Type)
    func send<R: AppRequest>(_ req: R) async throws -> R.Response
}


public final class EventBus: EventBusType {
    public init() {}

    // MARK: Events
    private var eventSubjects: [ObjectIdentifier: Any] = [:]
    private let lock = NSLock()

    private func subject<E: AppEvent>(for type: E.Type) -> PassthroughSubject<E, Never> {
        let key = ObjectIdentifier(type)
        lock.lock();
        defer { lock.unlock() }
        if let s = eventSubjects[key] as? PassthroughSubject<E, Never> { return s }
        let s = PassthroughSubject<E, Never>()
        eventSubjects[key] = s
        return s
    }

    public func publish<E: AppEvent>(_ event: E) {
        subject(for: E.self).send(event)
    }

    public func publisher<E: AppEvent>(_ type: E.Type) -> AnyPublisher<E, Never> {
        subject(for: E.self).eraseToAnyPublisher()
    }

    // MARK: Requests
    private var requestHandlers: [ObjectIdentifier: Any] = [:]

    public func register<R: AppRequest>(
        _ type: R.Type,
        handler: @escaping (R) async throws -> R.Response
    ) {
        let key = ObjectIdentifier(type)
        lock.lock();
        defer { lock.unlock() }
        requestHandlers[key] = handler
    }

    public func unregister<R: AppRequest>(_ type: R.Type) {
        let key = ObjectIdentifier(type)
        lock.lock();
        defer { lock.unlock() }
        requestHandlers.removeValue(forKey: key)
    }

    public func send<R: AppRequest>(_ req: R) async throws -> R.Response {
        let key = ObjectIdentifier(R.self)
        let anyHandler: Any?
        anyHandler = lock.withLock { requestHandlers[key] }

        guard let handler = anyHandler as? (R) async throws -> R.Response else {
            throw EventBusError.noHandlerRegistered(String(reflecting: R.self))
        }
        return try await handler(req)
    }
}


private extension NSLock {
    func withLock<T>(_ body: () throws -> T) rethrows -> T {
        self.lock()
        defer { self.unlock() }
        return try body()
    }
}
