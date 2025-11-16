//
//  EventReplay.swift
//  BookifySharedSystem
//
//  Created by radha chilamkurthy on 07/11/25.
//

import Foundation
import Combine

@propertyWrapper
public final class EventReplay<E: AppEvent> {
    private var cancellable: AnyCancellable?
    private let bus: EventBusType
    private let subject = CurrentValueSubject<E?, Never>(nil)

    public var wrappedValue: E? {
        subject.value
    }
    public var projectedValue: AnyPublisher<E, Never> {
        subject.compactMap { $0 }.eraseToAnyPublisher()
    }

    public init(bus: EventBusType, seed: E? = nil) {
        self.bus = bus
        subject.send(seed)
        self.cancellable = bus.publisher(E.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.subject.send($0) }
    }

    deinit { cancellable?.cancel() }
}
